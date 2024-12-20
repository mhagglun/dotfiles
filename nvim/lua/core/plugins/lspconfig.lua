return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "blink.cmp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "someone-stole-my-name/yaml-companion.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

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
                    -- default handler
                    function(server_name)
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
                                    -- Using Ruff"s import organizer
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
                        lspconfig.ts_ls.setup({
                            settings = {
                                typescript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all", -- "none" | "literals" | "all"
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = false,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                        includeInlayPropertyDeclarationTypeHints = false,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                            },
                        })
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
                        vim.keymap.set("n", "<leader>fy", function() require("core.yamlschema").pick_yaml_schema() end,
                            { desc = "Select yaml schema" })
                    end

                }
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    -- Disabled due to https://github.com/neovim/neovim/issues/23164
                    client.server_capabilities.semanticTokensProvider = nil

                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("n", "<leader>hs", function() vim.lsp.buf.signature_help() end, opts)
                    vim.keymap.set("n", "<leader>ca", function()
                        require("fzf-lua").lsp_code_actions {
                            winopts = {
                                relative = "cursor",
                                height = 0.33,
                                width = 0.33,
                                row = 1,
                                preview = { horizontal = "right:40%" },
                            },
                        }
                    end, { desc = "Code action" })

                    -- Toggle inlay hints
                    vim.keymap.set("n", "<leader>th",
                        function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
                        end, opts)
                    -- Fill inlay hints
                    vim.keymap.set("n", "<leader>hf", function()
                        require("core.inlayhints").fill()
                    end, { desc = "Fill inlay hint" })
                end,
            })
        end
    }
}
