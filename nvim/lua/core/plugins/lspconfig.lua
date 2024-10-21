return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "someone-stole-my-name/yaml-companion.nvim",
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
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
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
                    require("telescope").load_extension("yaml_schema")

                    local yamlls_capabilities = vim.lsp.protocol.make_client_capabilities()
                    yamlls_capabilities.textDocument.foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true
                    }
                    local cfg = require("yaml-companion").setup({
                        builtin_matchers = {
                            kubernetes = { enabled = true },
                        },
                        schemas = {
                            {
                                name = "Argo CD Application",
                                uri =
                                "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"
                            },
                            {
                                name = "Argo Workflows",
                                uri =
                                "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"
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
                                }
                            },
                        }
                    })
                    lspconfig.yamlls.setup(cfg)
                end

            }
        })
    end
}
