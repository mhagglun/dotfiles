vim.g.mapleader = " "
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'

-- Default indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50


-- Workaround for cmdheight = 0 breaking move lines
-- See  https://github.com/neovim/neovim/issues/20635#issuecomment-2198661759
vim.opt.report = 10

-- Hide cmdline
vim.opt.cmdheight = 0

-- Show cmd when recording macros
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        vim.opt.cmdheight = 1
    end
})
vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        vim.opt.cmdheight = 0
    end
})
