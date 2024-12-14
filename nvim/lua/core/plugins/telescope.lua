return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-live-grep-args.nvim", verson = "^1.0.0" }
    },

    config = function()
        local telescope = require("telescope")
        telescope.setup({})
        telescope.load_extension('fzf')
        telescope.load_extension('live_grep_args')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fs', '<cmd>Telescope yaml_schema<CR>', {})
        vim.keymap.set('n', '<leader>fr', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {})

    end
}
