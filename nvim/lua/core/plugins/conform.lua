return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
          sql = { "sqlfluff" },
          yaml = { "yamlfmt" },
          json = { "prettierd", "prettier", stop_after_first = true },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          ["*"] = { "injected" }, -- enables injected-lang formatting for all filetypes
        },
      })

      local km = vim.keymap
      km.set("n", "<leader>fm", function()
        conform.format({ async = true, lsp_fallback = true })
      end, { desc = "Format current buffer" })
    end,
  },
}
