local fzf = require("fzf-lua")
local actions = fzf.actions
fzf.setup({
  winopts = {
    border = "rounded",
  },
  keymap = {
    builtin = {
      true,
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
    fzf = {
      true,
      ["ctrl-d"] = "preview-page-down",
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-q"] = "select-all+accept",
    },
  },
  actions = {
    files = {
      ["enter"] = actions.file_edit_or_qf,
      ["ctrl-x"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
      ["alt-q"] = actions.file_sel_to_qf,
    },
  },
  buffers = {
    keymap = { builtin = { ["<C-d>"] = false } },
    actions = { ["ctrl-x"] = false, ["ctrl-d"] = { actions.buf_del, actions.resume } },
  },
})

-- Keymaps
local km = vim.keymap
km.set("n", "<leader>fd", ":FzfLua<CR>", { desc = "Fzf Open Dialog" })
km.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
km.set("n", "<leader>fb", fzf.buffers, { desc = "Find Buffers" })
km.set("n", "<leader>fg", fzf.git_files, { desc = "Find Git files" })
km.set("n", "<leader>fr", fzf.live_grep_glob, { desc = "Live grep" })
km.set("n", "<leader>fq", fzf.quickfix, { desc = "Open Quickfix" })
km.set("n", "<leader>fs", fzf.spell_suggest, { desc = "Spell suggest" })

-- Lsp stuff
km.set("n", "grr", fzf.lsp_references, { desc = "LSP References" })
km.set("n", "<leader>ca", function()
  require("fzf-lua").lsp_code_actions({
    winopts = {
      relative = "cursor",
      height = 0.2,
      width = 0.8,
      row = 1,
      preview = {
        layout = "horizontal",
        horizontal = "right:50%",
      },
    },
  })
end, { desc = "Code action" })
