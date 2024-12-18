return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")
        local actions = fzf.actions
        fzf.setup({
            winopts = {},
            keymap = {
                builtin = {
                    true,
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
                fzf = {
                    true,
                    ["ctrl-d"] = "preview-page-down",
                    ["ctrl-u"] = "preview-page-up",
                    ["ctrl-q"] = "select-all+accept",
                },
            },
            actions = {
                files = {
                    ["enter"]  = actions.file_edit_or_qf,
                    ["ctrl-x"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                    ["ctrl-t"] = actions.file_tabedit,
                    ["alt-q"]  = actions.file_sel_to_qf,
                },
            },
            buffers = {
                keymap = { builtin = { ["<C-d>"] = false } },
                actions = { ["ctrl-x"] = false, ["ctrl-d"] = { actions.buf_del, actions.resume } },
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>fd", ":FzfLua<CR>", { desc = "Fzf Open Dialog" })
        vim.keymap.set("n", "<leader>ff", function() fzf.files() end, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fb", function() fzf.buffers() end, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fg", function() fzf.git_files() end, { desc = "Find Git files" })
        vim.keymap.set("n", "<leader>fr", function() fzf.live_grep_glob() end, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fq", function() fzf.quickfix() end, { desc = "Find Quickfix" })
    end
}
