return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        "giuxtaposition/blink-cmp-copilot",
    },
    version = 'v0.*',
    opts = {
        keymap = {
            -- preset = 'super-tab',
            ['<C-p>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'cancel', 'fallback' },

            ['<Tab>'] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                'snippet_forward',
                'fallback',
            },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },
        completion = {
            menu = {
                border = 'none',
                draw = {
                    columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
                },
            },
        },
        signature = { enabled = true },
        sources = {
            completion = {
                enabled_providers = { "lsp", "path", "snippets", "buffer", "copilot" },
            },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    kind = "Copilot",
                    score_offset = 100,
                    async = true,
                    transform_items = function(_, items)
                        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                        local kind_idx = #CompletionItemKind + 1
                        CompletionItemKind[kind_idx] = "Copilot"
                        for _, item in ipairs(items) do
                            item.kind = kind_idx
                        end
                        return items
                    end,
                },
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
            kind_icons = {
                Copilot = "",
                Text = '󰉿',
                Method = '󰊕',
                Function = '󰊕',
                Constructor = '󰒓',

                Field = '󰜢',
                Variable = '󰆦',
                Property = '󰖷',

                Class = '󱡠',
                Interface = '󱡠',
                Struct = '󱡠',
                Module = '󰅩',

                Unit = '󰪚',
                Value = '󰦨',
                Enum = '󰦨',
                EnumMember = '󰦨',

                Keyword = '󰻾',
                Constant = '󰏿',

                Snippet = '󱄽',
                Color = '󰏘',
                File = '󰈔',
                Reference = '󰬲',
                Folder = '󰉋',
                Event = '󱐋',
                Operator = '󰪚',
                TypeParameter = '󰬛',
            },
        },
    }
}
