vim.g.mapleader = " "

local km = vim.keymap
-- Navigation
km.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
km.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
km.set({ "n", "v" }, "H", "^", { desc = "Move to first non-blank character" })
km.set({ "n", "v" }, "L", "$", { desc = "Move to end-of-line" })

km.set("i", "jj", "<Esc><right>", { desc = "Escape insert mode" })
km.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
km.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
km.set("n", "N", "Nzzzv", { desc = "Search previous and center cursor" })
km.set("n", "n", "nzzzv", { desc = "Search next and center cursor" })

-- Quick fix navigation
km.set("n", "[q", ":cp<CR>", { silent = true, desc = "Previous quickfix item" })
km.set("n", "]q", ":cn<CR>", { silent = true, desc = "Next quickfix item" })

-- Buffers
km.set("n", "<leader>q", "<cmd>bw<CR>", { desc = "Close buffer" })
km.set("n", "<leader>x", "<cmd>bd!<CR>", { desc = "Close buffer without saving" })
km.set("n", "<leader>n", "<cmd>enew<CR>", { desc = "Open a new empty buffer" })
km.set("n", "<leader><tab>", "<cmd>bn<CR>", { desc = "Go to next buffer" })
km.set("n", "<leader><S-tab>", "<cmd>bp<CR>", { desc = "Go to previous buffer" })

-- Windows
km.set("n", "<M-,>", "<c-w>5>", { desc = "Increase current window width" })
km.set("n", "<M-.>", "<c-w>5<", { desc = "Decrease current window width" })
km.set("n", "<M-t>", "<c-w>2+", { desc = "Increase current window height" })
km.set("n", "<M-s>", "<c-w>2-", { desc = "Decrease current window height" })

-- Indentation
km.set("n", "<tab>", ">>", { desc = "Increase indentation" })
km.set("n", "<S-tab>", "<<", { desc = "Decrease indentation" })
km.set("v", "<tab>", ">gv", { desc = "Increase indentation (visual mode)" })
km.set("v", "<S-tab>", "<gv", { desc = "Decrease indentation (visual mode)" })

-- Copy / Paste
km.set("x", "<leader>p", '"_DP', { desc = "Paste without copying replaced text to buffer" })
km.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
km.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
km.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without copying to buffer" })

km.set("n", "<leader>sp", "ggVGp", { desc = "Select all and paste" })
km.set("n", "<leader>sa", "ggVG", { desc = "Select all" })

-- Quick search/replace
km.set("n", "<leader>sr", [[:%s///g<Left><Left><Left>]], { desc = "Search and replace in file" })
km.set("n", "<leader>sl", [[:s///g<Left><Left><Left>]], { desc = "Search and replace on line" })

-- Save
km.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
km.set("c", "w!!", require("utils.write").sudo_write, { silent = true, desc = "Save as sudo" })

-- Terminal
km.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape terminal" })
km.set("t", "jj", "<c-\\><c-n>", { desc = "Escape terminal" })
km.set("n", "<leader>tt", require("utils.floatterm").toggle_term, {})
km.set("n", ",st", function()
  vim.cmd.new()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end, { desc = "Open terminal" })
