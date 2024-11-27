return {
    {
        'stevearc/conform.nvim',
        lazy = false,
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
                    json = { "prettierd", "prettier", stop_after_first = true },
                    yaml = { "yamlfmt" },
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                    typescript = { "prettierd", "prettier", stop_after_first = true },
                    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                },
            })
        end
    }
}
