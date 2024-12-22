require("kanagawa").setup({
  compile = false, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = { bold = false },
  keywordStyle = { bold = false },
  statementStyle = { bold = false },
  typeStyle = { bold = false },
  transparent = false, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  terminalColors = false, -- define vim.g.terminal_color_{0,17}
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
  theme = "storm",
  overrides = function(colors)
    local theme = colors.theme
    return {
      LineNr = { bg = "none" },
      -- add `blend = vim.o.pumblend` to enable transparency
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
      LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
    }
  end,
})
vim.cmd("colorscheme kanagawa")
