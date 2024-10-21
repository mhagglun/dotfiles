return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function ()
        local neogit = require("neogit")
        neogit.setup({
            -- kind = "split_above"
            kind = "tab"
        })

        vim.keymap.set("n", "<leader>gs", function () neogit.open() end)
    end
}
