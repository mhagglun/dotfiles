local neogit = require("neogit")
neogit.setup({
  -- kind = "split_above"
  kind = "tab",
})

vim.keymap.set("n", "<leader>gs", function()
  neogit.open()
end)
