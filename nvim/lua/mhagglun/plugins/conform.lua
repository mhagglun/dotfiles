return {
    {
        'stevearc/conform.nvim',
        lazy = false,
        opts = {},

        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "ruff_format", "ruff_organize_imports" },
                },
                -- Set to enable
                -- format_on_save = {
                --     -- These options will be passed to conform.format()
                --     timeout_ms = 500,
                --     lsp_format = "fallback",
                -- },
            })
        end
    }
}
