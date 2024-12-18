return {
    {
        "sainnhe/gruvbox-material",
        name = "gruvbox-material",
        config = function()
            vim.o.background="dark"
            vim.g.gruvbox_material_better_performance = 1
            -- Fonts
            vim.g.gruvbox_material_disable_italic_comment = 0
            vim.g.gruvbox_material_enable_italic = 0
            vim.g.gruvbox_material_enable_bold = 0
            vim.g.gruvbox_material_transparent_background = 1

            -- Themes
            vim.g.gruvbox_material_statusline_style = "material"
            vim.g.gruvbox_material_foreground = "material"
            vim.g.gruvbox_material_background = "dark"
            vim.g.gruvbox_material_ui_contrast = "soft" -- The contrast of line numbers, indent lines, etc.
            vim.g.gruvbox_material_float_style = "dim"  -- Background of floating windows

            vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
            vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
            vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

            vim.cmd("colorscheme gruvbox-material")
        end
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        name = "kanagawa",
        config = function()
            require("kanagawa").setup({
                compile = false,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = { bold = false },
                keywordStyle = { bold = false },
                statementStyle = { bold = false },
                typeStyle = { bold = false },
                transparent = false,    -- do not set background color
                dimInactive = false,    -- dim inactive window `:h hl-NormalNC`
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
                        LineNr = { bg = "none" },

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
            -- vim.cmd("colorscheme kanagawa")
        end
    },
}
