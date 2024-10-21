return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    end
}
