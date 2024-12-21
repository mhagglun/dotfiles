local M = {}

function M.setup(lspconfig, capabilities)
  local yamlls_capabilities = vim.deepcopy(capabilities)
  -- Ensure foldingRange is initialized in capabilities
  yamlls_capabilities.textDocument = yamlls_capabilities.textDocument or {}
  yamlls_capabilities.textDocument.foldingRange = yamlls_capabilities.textDocument.foldingRange
    or {}

  yamlls_capabilities.textDocument.foldingRange.dynamicRegistration = false
  yamlls_capabilities.textDocument.foldingRange.lineFoldingOnly = true

  local cfg = require("yaml-companion").setup({
    builtin_matchers = {
      kubernetes = { enabled = true },
    },
    schemas = {
      {
        name = "Argo CD Application",
        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
      },
      {
        name = "Argo Workflows",
        uri = "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json",
      },
    },
    lspconfig = {
      capabilities = yamlls_capabilities,
      flags = {
        debounce_text_changes = 150,
      },
      settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
          validate = true,
          completion = true,
          format = { enabled = true },
          hover = true,
          schemaStore = {
            enable = true,
            url = "https://www.schemastore.org/api/json/catalog.json",
          },
        },
      },
    },
  })
  lspconfig.yamlls.setup(cfg)

  vim.keymap.set(
    "n",
    "<leader>fy",
    require("core.yamlschema").pick_yaml_schema,
    { desc = "Select yaml schema" }
  )
end

return M
