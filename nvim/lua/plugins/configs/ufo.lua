local ftMap = {
  vim = "indent",
  python = { "treesitter", "indent" },
  git = "",
}

require("ufo").setup({
  open_fold_hl_timeout = 150,
  close_fold_kinds_for_ft = {
    default = { "imports", "comment" },
    json = { "array" },
    c = { "comment" },
  },

  -- Use different providers for certain filetypes
  -- Default is lsp
  ---@diagnostic disable-next-line: unused-local
  provider_selector = function(bufnr, filetype, buftype)
    return ftMap[filetype]
  end,
})

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
