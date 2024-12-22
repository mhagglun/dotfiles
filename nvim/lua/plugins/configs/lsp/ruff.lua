local M = {}

function M.setup(lspconfig, capabilities)
  lspconfig.ruff.setup({
    capabilities = capabilities,
    init_options = {
      settings = {
        args = { "--fix", "--select", "I" },
      },
    },
  })
end

return M
