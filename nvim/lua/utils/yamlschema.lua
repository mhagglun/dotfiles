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
  schema_cache = {}, -- Cache for downloaded schemas
}

M.schema_url = "https://raw.githubusercontent.com/"
  .. M.schemas_catalog
  .. "/"
  .. M.schema_catalog_branch

-- Download and cache the list of CRDs
M.list_github_tree = function()
  if M.schema_cache.trees then
    return M.schema_cache.trees -- Return cached data if available
  end

  local url = M.github_base_api_url
    .. "/"
    .. M.schemas_catalog
    .. "/git/trees/"
    .. M.schema_catalog_branch
  local response = curl.get(url, { headers = M.github_headers, query = { recursive = 1 } })
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
  M.schema_cache.trees = trees -- Cache the list of CRDs
  return trees
end

-- Extract apiVersion and kind from YAML content
M.extract_api_version_and_kind = function(buffer_content)
  if not buffer_content or buffer_content == "" then
    return nil, nil
  end

  -- Remove the document separator (---) if present
  buffer_content = buffer_content:gsub("%-%-%-%s*\n", "")

  -- Scan the entire file for apiVersion and kind
  local api_version = buffer_content:match("apiVersion:%s*([%w%.%/%-]+)")
  local kind = buffer_content:match("kind:%s*([%w%-]+)")

  return api_version, kind
end

-- Normalize apiVersion and kind to match CRD schema naming convention
M.normalize_crd_name = function(api_version, kind)
  if not api_version or not kind then
    return nil
  end

  -- Split apiVersion into group and version (e.g., "argoproj.io/v1alpha1" -> "argoproj.io", "v1alpha1")
  local group, version = api_version:match("([%w%.]+)/([%w%-.]+)")
  if not group or not version then
    return nil
  end

  -- Normalize kind to lowercase
  local normalized_kind = kind:lower()

  -- Construct the CRD name in the format: group/normalized_kind_version.json
  return group .. "/" .. normalized_kind .. "_" .. version .. ".json"
end

-- Match the CRD schema based on apiVersion and kind
M.match_crd = function(buffer_content)
  local api_version, kind = M.extract_api_version_and_kind(buffer_content)
  if not api_version or not kind then
    return nil
  end

  local crd_name = M.normalize_crd_name(api_version, kind)
  if not crd_name then
    return nil
  end

  local all_crds = M.list_github_tree()
  for _, crd in ipairs(all_crds) do
    if crd:match(crd_name) then
      return crd
    end
  end
  return nil
end

-- Attach a schema to the current buffer
M.attach_schema = function(bufnr, schema_url, description)
  local clients = vim.lsp.get_clients({ name = "yamlls" })
  if #clients == 0 then
    vim.notify("yaml-language-server is not active.", vim.log.levels.WARN)
    return
  end
  local yaml_client = clients[1]

  -- Clear existing schema associations for this buffer
  yaml_client.config.settings = yaml_client.config.settings or {}
  yaml_client.config.settings.yaml = yaml_client.config.settings.yaml or {}
  yaml_client.config.settings.yaml.schemas = yaml_client.config.settings.yaml.schemas or {}

  -- Reset schemas for the buffer to avoid applying previous settings globally
  for schema in pairs(yaml_client.config.settings.yaml.schemas) do
    if yaml_client.config.settings.yaml.schemas[schema] == "*.yaml" then
      yaml_client.config.settings.yaml.schemas[schema] = nil
    end
  end

  -- Attach the schema only for the current buffer
  yaml_client.config.settings.yaml.schemas[schema_url] = vim.api.nvim_buf_get_name(bufnr)

  -- Notify the server of the configuration change
  yaml_client.notify("workspace/didChangeConfiguration", {
    settings = yaml_client.config.settings,
  })
end

-- Allow the user to pick a schema manually and add modeline
M.pick_schema = function(bufnr)
  -- Fetch the list of schemas
  local all_crds = M.list_github_tree()

  if #all_crds == 0 then
    vim.notify("No schemas are available to select from.", vim.log.levels.WARN)
    return
  end

  -- Use fzf-lua to display and select a schema
  fzf.fzf_exec(all_crds, {
    prompt = "Select a schema: ",
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        -- Build the schema URL
        local schema_path = selected[1]
        local schema_url = M.schema_url .. "/" .. schema_path

        -- Construct the modeline
        local modeline = "# yaml-language-server: $schema=" .. schema_url

        -- Add the modeline at the top of the buffer
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { modeline })
      end,
    },
  })
end

-- Get the correct Kubernetes schema URL based on apiVersion and kind
M.get_kubernetes_schema_url = function(api_version, kind)
  if not api_version or not kind then
    return nil
  end

  local version = api_version:match("/([%w%-]+)$") or api_version
  local schema_name

  -- Check schema with version suffix (E.g., "deployment-v1.json")
  schema_name = kind:lower() .. "-" .. version .. ".json"
  local url_with_version = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/"
    .. schema_name

  -- Check schema without version suffix (E.g., "deployment.json")
  local url_without_version = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/"
    .. kind:lower()
    .. ".json"

  -- Try to fetch schema with version suffix
  local response_with_version = curl.get(url_with_version, { headers = M.github_headers })
  if response_with_version.status == 200 then
    return url_with_version
  end

  -- Try to fetch schema without version
  local response_without_version = curl.get(url_without_version, { headers = M.github_headers })
  if response_without_version.status == 200 then
    return url_without_version
  end

  -- Return nil if both checks fail
  return nil
end

-- Initialize the schema attachment for the specified buffer
M.init = function(bufnr)
  -- Clear any previously attached schema for this buffer
  vim.b[bufnr].schema_attached = nil

  -- Check if the schema has already been attached to this buffer
  if vim.b[bufnr].schema_attached then
    return
  end
  vim.b[bufnr].schema_attached = true -- Mark the schema as attached

  local buffer_content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  local crd = M.match_crd(buffer_content)
  if crd then
    -- Attach the CRD schema
    local schema_url = M.schema_url .. "/" .. crd
    M.attach_schema(bufnr, schema_url, "CRD schema for " .. crd)
  else
    -- Check if the file is a Kubernetes YAML file
    local api_version, kind = M.extract_api_version_and_kind(buffer_content)
    if api_version and kind then
      -- Attach the Kubernetes schema
      local kubernetes_schema_url = M.get_kubernetes_schema_url(api_version, kind)
      if kubernetes_schema_url then
        M.attach_schema(bufnr, kubernetes_schema_url, "Kubernetes schema for " .. kind)
      end
    end
  end
end

return M
