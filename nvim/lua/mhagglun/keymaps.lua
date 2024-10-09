vim.g.mapleader = " "

-- File explorer
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>e", function () require("oil").toggle_float() end, { desc = "Open file explorer" })


-- Navigation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })

vim.keymap.set("n", "<leader>q", "<cmd>bw<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>n", "<cmd>enew<CR>", { desc = "Open a new empty buffer" })
vim.keymap.set("n", "<leader><tab>", "<cmd>bn<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader><S-tab>", "<cmd>bp<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader><esc>", function() require('notify').dismiss() end, { desc = "Clear notifications" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous and center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search next and center cursor" })
vim.keymap.set("n", "<BS>", "^", { desc = "Move to first non-blank character" })


-- Copy / pasting
vim.keymap.set("x", "<leader>p", "\"_DP", { desc = "Delete without copying to buffer" })
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank line to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank selection to system clipboard" })

vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete without copying to buffer" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete selected text without copying to buffer" })

vim.keymap.set("n", "<leader>pa", "ggVGp", { desc = "Select all and paste" })
vim.keymap.set("n", "<leader>sa", "ggVG", { desc = "Select all" })
vim.keymap.set("n", "L", "vg_", { desc = "Select to end of line" })

-- Indentation
vim.keymap.set("n", "<", "<<", { desc = "Decrease indentation" })
vim.keymap.set("n", ">", ">>", { desc = "Increase indentation" })

vim.keymap.set("v", "<", "<gv", { desc = "Decrease indentation (visual mode)" })
vim.keymap.set("v", ">", ">gv", { desc = "Increase indentation (visual mode)" })

-- Resize windows
vim.keymap.set("n", "<M-,>", "<c-w>5>", { desc = "Increase current window width" })
vim.keymap.set("n", "<M-.>", "<c-w>5<", { desc = "Decrease current window width" })
vim.keymap.set("n", "<M-t>", "<c-w>2+", { desc = "Increase current window height" })
vim.keymap.set("n", "<M-s>", "<c-w>2-", { desc = "Decrease current window height" })

-- Format & Comments
vim.keymap.set("n", "<leader>fm", function() require('conform').format { async = true, lsp_fallback = true } end, { desc = "Format current buffer" })
vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle line comment" })
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle line comment on selection" })

vim.keymap.set('n', '<leader>sr', [[:%s///g<Left><Left><Left>]], { desc = "Search and replace in file" })
vim.keymap.set('n', '<leader>sl', [[:s///g<Left><Left><Left>]], { desc = "Search and replace on line" })
vim.keymap.set('v', '<leader>sr', '"hy:%s/\\v<C-r>h//g<left><left>', { desc = "Replace selection in file" })
vim.keymap.set('v', '<leader>sl', '"hy:s/\\v<C-r>h//g<left><left>', { desc = "Replace selection on line" })

-- Save
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("c", "w!!", require("mhagglun.utils").sudo_write, { silent = true, desc = "Save as sudo" })

-- Terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape terminal" })
vim.keymap.set("n", ",st", function ()
        vim.cmd.new()
        vim.cmd.wincmd "J"
        vim.api.nvim_win_set_height(0, 12)
        vim.wo.winfixheight = true
        vim.cmd.term()
    end,
    { desc = "Open terminal"}
)


