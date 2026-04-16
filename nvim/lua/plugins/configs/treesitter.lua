require("nvim-treesitter").setup({
  parsers = {
    templ = {
      install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
      },
    },
  },
})

vim.treesitter.language.register("templ", "templ")

-- Enable treesitter highlighting and indentation via FileType autocmd.
-- The new nvim-treesitter (main branch) no longer handles this through setup().
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Install any missing parsers on startup (replaces ensure_installed).
local ensure_installed = {
  "c",
  "go",
  "vimdoc",
  "bash",
  "lua",
  "sql",
  "diff",
  "python",
  "markdown",
  "typescript",
  "terraform",
  "yaml",
  "rst",
  "templ",
}

local already_installed = require("nvim-treesitter.config").get_installed()
local to_install = vim
  .iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(already_installed, parser)
  end)
  :totable()

if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end
