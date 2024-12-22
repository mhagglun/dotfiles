local M = {}

function M.setup(lspconfig, capabilities)
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
        },
      },
    },
  })
end

return M
