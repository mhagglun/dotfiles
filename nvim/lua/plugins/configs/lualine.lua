require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      { "mode", fmt = string.lower },
    },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = "●",
        },
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
      },
    },
    lualine_y = {
      {
        function()
          local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
          local icon =
            require("mini.icons").get("filetype", vim.api.nvim_buf_get_option(0, "filetype"))
          if lsps and #lsps > 0 then
            local names = {}
            for _, lsp in ipairs(lsps) do
              table.insert(names, lsp.name)
            end
            return string.format("%s %s", icon, table.concat(names, ", "))
          else
            return icon or ""
          end
        end,
        on_click = function()
          vim.api.nvim_command("LspInfo")
        end,
      },
    },
    lualine_z = {
      { "location" },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
