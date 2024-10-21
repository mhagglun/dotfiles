return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        --LspInfo Borders
        require("lspconfig.ui.windows").default_options.border = "double"
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "basedpyright",
                "ruff",
                "lua_ls",
                "gopls",
                "yamlls",
                "ts_ls",
                "terraformls",
            },
            handlers = {

                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,

                -- Lua
                ["lua_ls"] = function()
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
                end,

                ["basedpyright"] = function()
                    local pyright_capabilities = vim.lsp.protocol.make_client_capabilities()
                    pyright_capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
                    lspconfig.basedpyright.setup({
                        capabilities = pyright_capabilities,
                        settings = {
                            basedpyright = {
                                -- Using Ruff's import organizer
                                disableOrganizeImports = true,
                                analysis = {
                                    typeCheckingMode = "basic", -- off, basic, standard, strict, all
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
                end,


                ["ruff"] = function()
                    lspconfig.ruff.setup({
                        capabilities = capabilities,
                        init_options = {
                            settings = {
                                args = { "--fix", "--select", "I" },
                            }
                        },
                    })
                end,

                ["ts_ls"] = function()
                    lspconfig.ts_ls.setup({})
                end,

                ["gopls"] = function()
                    lspconfig.gopls.setup({
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,
                                },
                                staticcheck = true,
                                gofumpt = true,
                            },
                        },
                    })
                end,

                ["yamlls"] = function()
                    local yamll_capabilities = vim.lsp.protocol.make_client_capabilities()
                    yamll_capabilities.textDocument.foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true
                    }
                    lspconfig.yamlls.setup {
                        capabilities = yamll_capabilities,
                        settings = {
                            yaml = {
                                schemaStore = {
                                    enable = true,
                                    url = "https://www.schemastore.org/api/json/catalog.json",
                                },
                                schemas = {
                                    kubernetes = "*.yaml",
                                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                                    ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines*.{yml,yaml}",
                                    ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/*.{yml,yaml}",
                                    ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
                                    ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                                    ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                                    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                                    ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                                    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
                                    ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                                    ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
                                },
                                format = { enabled = true },
                                validate = true,
                                completion = true,
                                hover = true,
                            }
                        }
                    }
                end

            }
        })
    end
}
