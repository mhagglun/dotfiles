return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "b0o/schemastore.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local lspui = require("lspconfig.ui.windows")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        --LspInfo Borders
        lspui.default_options.border = "double"

        -- Manage language servers individually
        -- Lua LS
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

        -- Python
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
        lspconfig.ruff.setup({
            capabilities = capabilities,
            init_options = {
                settings = {
                    args = { "--fix", "--select", "I" },
                }
            },
        })

        -- Go
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

        -- YAML
        local yamll_capabilities = vim.lsp.protocol.make_client_capabilities()
        yamll_capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        lspconfig.yamlls.setup {
            capabilities = yamll_capabilities,
            settings = {
                yaml = {
                    format = {
                        enable = true
                    },
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    schemas = require('schemastore').yaml.schemas(),
                }
            }
        }
    end,
}
