local M = {}

function M.setup(lspconfig, capabilities)
  local pyright_capabilities = vim.deepcopy(capabilities)
  pyright_capabilities.textDocument.publishDiagnostics = pyright_capabilities.textDocument.publishDiagnostics or {}
  pyright_capabilities.textDocument.publishDiagnostics.tagSupport = { valueSet = { 2 } }

  lspconfig.basedpyright.setup({
    capabilities = pyright_capabilities,
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          autoImportCompletions = true,
          diagnosticSeverityOverrides = {
            reportUnusedClass = "warning",
            reportUnusedFunction = "warning",
          },
        },
      },
    },
  })
end

return M
