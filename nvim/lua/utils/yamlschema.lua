local curl = require("plenary.curl")
local fzf = require("fzf-lua")
local M = {
  schemas_catalog = "datreeio/CRDs-catalog",
  schema_catalog_branch = "main",
  github_base_api_url = "https://api.github.com/repos",
  github_headers = {
    Accept = "application/vnd.github+json",
    ["X-GitHub-Api-Version"] = "2022-11-28",
  },
  schema_cache = {},
}

M.schema_url = "https://raw.githubusercontent.com/"
  .. M.schemas_catalog
  .. "/"
  .. M.schema_catalog_branch

M.list_github_tree = function(callback)
  if M.schema_cache.trees then
    callback(M.schema_cache.trees)
    return
  end

  local url = M.github_base_api_url
    .. "/"
    .. M.schemas_catalog
    .. "/git/trees/"
    .. M.schema_catalog_branch

  curl.get(url, {
    headers = M.github_headers,
    query = { recursive = 1 },
    callback = vim.schedule_wrap(function(response)
      local body = vim.fn.json_decode(response.body)
      local trees = {}
      if body and body.tree then
        for _, tree in ipairs(body.tree) do
          if tree.type == "blob" and tree.path:match("%.json$") then
            table.insert(trees, tree.path)
          end
        end
      else
        vim.notify("Failed to fetch schema list from GitHub.", vim.log.levels.ERROR)
      end
      M.schema_cache.trees = trees
      callback(trees)
    end),
  })
end

M.extract_api_version_and_kind = function(buffer_content)
  if not buffer_content or buffer_content == "" then
    return nil, nil
  end

  buffer_content = buffer_content:gsub("%-%-%-%s*\n", "")

  local api_version = buffer_content:match("apiVersion:%s*([%w%.%/%-]+)")
  local kind = buffer_content:match("kind:%s*([%w%-]+)")

  return api_version, kind
end

M.normalize_crd_name = function(api_version, kind)
  if not api_version or not kind then
    return nil
  end

  local group, version = api_version:match("([%w%.]+)/([%w%-.]+)")
  if not group or not version then
    return nil
  end

  local normalized_kind = kind:lower()

  return group .. "/" .. normalized_kind .. "_" .. version .. ".json"
end

M.attach_schema = function(bufnr, schema_url, description)
  local clients = vim.lsp.get_clients({ name = "yamlls" })
  if #clients == 0 then
    vim.notify("yaml-language-server is not active.", vim.log.levels.WARN)
    return
  end
  local yaml_client = clients[1]

  yaml_client.config.settings = yaml_client.config.settings or {}
  yaml_client.config.settings.yaml = yaml_client.config.settings.yaml or {}
  yaml_client.config.settings.yaml.schemas = yaml_client.config.settings.yaml.schemas or {}

  for schema in pairs(yaml_client.config.settings.yaml.schemas) do
    if yaml_client.config.settings.yaml.schemas[schema] == "*.yaml" then
      yaml_client.config.settings.yaml.schemas[schema] = nil
    end
  end

  yaml_client.config.settings.yaml.schemas[schema_url] = vim.api.nvim_buf_get_name(bufnr)

  yaml_client.notify("workspace/didChangeConfiguration", {
    settings = yaml_client.config.settings,
  })
end

M.get_kubernetes_schema_url = function(api_version, kind, callback)
  if not api_version or not kind then
    callback(nil)
    return
  end

  local version = api_version:match("/([%w%-]+)$") or api_version
  local url_with_version = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/"
    .. kind:lower()
    .. "-"
    .. version
    .. ".json"
  local url_without_version = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/"
    .. kind:lower()
    .. ".json"

  curl.get(url_with_version, {
    headers = M.github_headers,
    callback = vim.schedule_wrap(function(response)
      if response.status == 200 then
        callback(url_with_version)
      else
        curl.get(url_without_version, {
          headers = M.github_headers,
          callback = vim.schedule_wrap(function(response2)
            callback(response2.status == 200 and url_without_version or nil)
          end),
        })
      end
    end),
  })
end

M.pick_schema = function(bufnr)
  M.list_github_tree(function(all_crds)
    if #all_crds == 0 then
      vim.notify("No schemas are available to select from.", vim.log.levels.WARN)
      return
    end

    fzf.fzf_exec(all_crds, {
      prompt = "Select a schema: ",
      actions = {
        ["default"] = function(selected)
          if not selected or #selected == 0 then
            return
          end

          local schema_path = selected[1]
          local schema_url = M.schema_url .. "/" .. schema_path
          local modeline = "# yaml-language-server: $schema=" .. schema_url

          vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { modeline })
        end,
      },
    })
  end)
end

M.init = function(bufnr)
  if vim.b[bufnr].schema_attached then
    return
  end
  vim.b[bufnr].schema_attached = true

  local buffer_content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  local api_version, kind = M.extract_api_version_and_kind(buffer_content)
  if not api_version or not kind then
    return
  end

  local crd_name = M.normalize_crd_name(api_version, kind)
  if crd_name then
    M.list_github_tree(function(trees)
      for _, crd in ipairs(trees) do
        if crd:match(crd_name) then
          M.attach_schema(bufnr, M.schema_url .. "/" .. crd, "CRD schema for " .. crd)
          return
        end
      end
      M.get_kubernetes_schema_url(api_version, kind, function(url)
        if url then
          M.attach_schema(bufnr, url, "Kubernetes schema for " .. kind)
        end
      end)
    end)
  else
    M.get_kubernetes_schema_url(api_version, kind, function(url)
      if url then
        M.attach_schema(bufnr, url, "Kubernetes schema for " .. kind)
      end
    end)
  end
end

return M
