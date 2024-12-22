local M = {}

function M.setup(lspconfig, capabilities)
  lspconfig.clangd.setup({
    capabilities = capabilities,
  })
end

return M
