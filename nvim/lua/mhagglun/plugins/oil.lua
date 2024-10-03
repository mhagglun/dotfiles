return {
    'stevearc/oil.nvim',
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
        require("oil").setup({
            columns = { "icon" },
            use_default_keymaps = false,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                -- ["<C-t>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                -- ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            view_options = {
                show_hidden = true,
            },
            float = {
                preview_split = "right",
            }
        })
    end
}
