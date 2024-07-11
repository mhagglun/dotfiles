return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local function disable_semantic_tokens(client)
            -- Function to disable semantic tokens for a client
            -- Disabled due to https://github.com/neovim/neovim/issues/23164
            client.server_capabilities.semanticTokensProvider = nil
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                disable_semantic_tokens(client)

                local opts = { buffer = event.buf }

                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set('n', '<leader>gr', function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set('n', '<leader>h', function() vim.lsp.buf.signature_help() end, opts)
            end,
        })

        local cmp = require('cmp')
        local luasnip = require("luasnip")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "basedpyright",
                "ruff",
                "lua_ls",
                "gopls",
                "rust_analyzer",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                -- runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

                ["ruff"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ruff.setup {
                        capabilities = capabilities,
                        init_options = {
                            settings = {
                                -- Any extra CLI arguments for `ruff` go here.
                                args = { "--fix", "--select", "I" },
                            }
                        },
                        ---@diagnostic disable-next-line: unused-local
                        on_attach = function(client, bufnr)
                            -- Disable hoverProvider for Ruff
                            client.server_capabilities.hoverProvider = false
                            client.server_capabilities.disableHoverProvider = false

                            -- Create ruff commands
                            vim.api.nvim_create_user_command('RuffAutoFix', function()
                                vim.lsp.buf.execute_command {
                                    command = 'ruff.applyAutofix',
                                    arguments = {
                                        { uri = vim.uri_from_bufnr(0) },
                                    },
                                }
                            end, { desc = 'Ruff: Fix all auto-fixable problems' })

                            vim.api.nvim_create_user_command('RuffOrganizeImports', function()
                                vim.lsp.buf.execute_command {
                                    command = 'ruff.applyOrganizeImports',
                                    arguments = {
                                        { uri = vim.uri_from_bufnr(0) },
                                    },
                                }
                            end, { desc = 'Ruff: Format imports' })
                        end
                    }
                end,

                ["basedpyright"] = function()
                    local lspconfig = require("lspconfig")
                    local pyright_capabilities = vim.lsp.protocol.make_client_capabilities()
                    pyright_capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
                    lspconfig.basedpyright.setup {
                        capabilities = pyright_capabilities,
                        settings = {
                            basedpyright = {
                                -- Using Ruff's import organizer
                                disableOrganizeImports = true,
                                typeCheckingMode = 'basic',
                            },
                        },
                    }
                end,
            }
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<Up>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                ['<Down>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<Enter>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
