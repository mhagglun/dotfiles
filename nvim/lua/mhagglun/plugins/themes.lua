return {
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        -- lazy = false,
        opts = {},
        config = function()
            require("tokyonight").setup({
                style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true,     -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = {},
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark",   -- style for floating windows
                },
            })
            -- vim.cmd("colorscheme tokyonight-night")
        end
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = false,
        config = function()
            require('kanagawa').setup({
                compile = false,   -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = { bold = false },
                keywordStyle = { bold = false },
                statementStyle = { bold = false },
                typeStyle = { bold = false },
                transparent = false,   -- do not set background color
                dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
                terminalColors = false, -- define vim.g.terminal_color_{0,17}
                colors = {

                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                },
                theme = "storm",
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        LineNr = { bg = 'none' },

                        -- telescope
                        TelescopeTitle = { fg = theme.ui.special, bold = true },
                        TelescopePromptNormal = { bg = theme.ui.bg },
                        TelescopePromptBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
                        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
                        TelescopeResultsBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
                        TelescopePreviewNormal = { bg = theme.ui.bg },
                        TelescopePreviewBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },

                        -- popup menus
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },

                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
            })
            vim.cmd("colorscheme kanagawa")
        end
    },
}
