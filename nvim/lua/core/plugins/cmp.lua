return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "neovim/nvim-lspconfig",
    },

    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                -- Disabled due to https://github.com/neovim/neovim/issues/23164
                client.server_capabilities.semanticTokensProvider = nil

                local opts = { buffer = event.buf }

                vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
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
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completeopt = "menu,menuone,preview,noselect",
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
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
            })
        })
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
        vim.api.nvim_create_autocmd({ 'VimEnter', 'VimResized' }, {
            desc = 'Setup LSP hover window',
            callback = function()
                local width = math.floor(vim.o.columns * 0.5)
                local height = math.floor(vim.o.lines * 0.5)

                vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                    border = 'rounded',
                    max_width = width,
                    max_height = height,
                })
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
        )
            end,
        })
        vim.diagnostic.config({
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
