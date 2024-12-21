return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    config = function()
      local presets = require("markview.presets")
      require("markview").setup({
        headings = presets.headings.marker,
      })
    end,
  },
}
