return {
    "folke/zen-mode.nvim",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                window = {
                    width = 120,
                    options = { }
                },
            }
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = false
            vim.wo.rnu = false
            vim.opt.colorcolumn = "0"
        end)
    end
}
