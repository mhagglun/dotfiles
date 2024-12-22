local M = {}

function M.setup(lspconfig, capabilities)
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
      capabilities = capabilities,
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
    require("utils.yamlschema").pick_yaml_schema,
    { desc = "Select yaml schema" }
  )
end

return M
