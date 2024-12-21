return {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup({
      padding = true,
      ignore = "^$", -- ignore empty lines
      mappings = {
        basic = true,
        extra = true,
      },
    })
  end,
}
