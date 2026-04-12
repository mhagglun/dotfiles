local presets = require("markview.presets")
require("markview").setup({
  markdown = {
    enable = false,
    headings = presets.headings.marker,
  },
})
