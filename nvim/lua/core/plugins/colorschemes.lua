return {
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = false,
    config = function()
      -- Fonts
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_enable_bold = 0
      vim.g.gruvbox_material_transparent_background = 1

      -- Themes
      vim.g.gruvbox_material_statusline_style = "material"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_background = "dark"
      vim.g.gruvbox_material_ui_contrast = "low"
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_menu_selection_background = "green"
      vim.g.gruvbox_material_better_performance = 1

      vim.cmd("colorscheme gruvbox-material")

      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

      -- Blink
      vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "NormalFloat" })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    name = "kanagawa",
    config = function()
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
    end,
  },
}
