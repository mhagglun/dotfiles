vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- navigation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy / pasting
vim.keymap.set("x", "<leader>p", "\"_DP")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")


vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":bw<CR>")
vim.keymap.set("n", "<leader>b", ":enew<CR>")
vim.keymap.set("n", "<leader><tab>", ":bn<CR>")
vim.keymap.set("n", "<leader><S-tab>", ":bp<CR>")

-- indent
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
