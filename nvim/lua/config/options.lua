local opt = vim.opt

opt.nu = true
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.spelllang = { "en_us" }

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.wrap = true
opt.linebreak = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
vim.o.shortmess = vim.o.shortmess .. "S" -- stops display of current search match in cmdline area

opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- folds
opt.foldenable = true
opt.foldcolumn = "0"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.fillchars = { eob = " ", fold = " ", foldopen = " ", foldsep = " ", foldclose = " " }

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.updatetime = 50

opt.guicursor = ""
opt.termguicolors = true
opt.background = "dark"

-- split window preferences
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word

-- workaround for cmdheight = 0 breaking move lines
-- see  https://github.com/neovim/neovim/issues/20635#issuecomment-2198661759
opt.report = 10
-- hide cmdline
opt.cmdheight = 0

-- Show cmd when recording macros
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    opt.cmdheight = 1
  end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    opt.cmdheight = 0
  end,
})
