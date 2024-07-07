return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function()
            require("tokyonight").setup({
                style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true,     -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark",   -- style for floating windows
                },
            })
            vim.cmd("colorscheme tokyonight-storm")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        -- lazy = false,
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })
            -- vim.cmd("colorscheme rose-pine-moon")
        end
    },

}
