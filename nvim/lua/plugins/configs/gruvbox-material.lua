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
