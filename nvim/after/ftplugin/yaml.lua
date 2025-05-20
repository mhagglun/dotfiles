vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter" }, {
  pattern = { "*.yaml", "*.yml" },
  callback = function(args)
    local bufnr = args.buf

    -- Ensure this is actually a YAML file (skip if not)
    if vim.bo[bufnr].filetype ~= "yaml" then
      return
    end

    vim.defer_fn(function()
      -- Check if `yamlls` is attached to this buffer
      local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "yamlls" })
      if #clients > 0 then
        -- yamlls is already running, initialize schema logic
        require("utils.yamlschema").init(bufnr)
      else
        vim.notify(
          "[yamlschema] Waiting for yaml-language-server to attach...",
          vim.log.levels.DEBUG
        )
        -- Wait for LSP to attach
        vim.api.nvim_create_autocmd("LspAttach", {
          once = true,
          buffer = bufnr,
          callback = function(lsp_args)
            local client = vim.lsp.get_client_by_id(lsp_args.data.client_id)
            if client and client.name == "yamlls" then
              require("utils.yamlschema").init(bufnr)
            end
          end,
        })
      end
    end, 100) -- Defer execution by 100ms to ensure buffer initialization completes
  end,
})
