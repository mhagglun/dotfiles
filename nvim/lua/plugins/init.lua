return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "saghen/blink.cmp",
    version = "v1.3.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it"s only enabled if any extras need it
      },
    },
    opts = require("plugins.configs.blink"),
    opts_extend = { "sources.default" },
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      require("plugins.configs.fzf")
    end,
  },
  {
    "stevearc/conform.nvim",
    lazy = false,
    config = function()
      require("plugins.configs.conform")
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("plugins.configs.comment")
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- stylua: ignore start
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    -- stylua ignore end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
      vim.cmd("Copilot disable")
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          width = 0.8,
          height = 0.8,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "someone-stole-my-name/yaml-companion.nvim",
    },
    config = function()
      require("plugins.configs.lspconfig")
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    config = function()
      require("plugins.configs.ufo")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.configs.gitsigns")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      require("plugins.configs.lualine")
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    config = function()
      require("plugins.configs.markview")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    config = function()
      require("plugins.configs.neogit")
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.configs.notify")
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
      require("plugins.configs.oil")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end,
  },
  {
    "folke/zen-mode.nvim",
    lazy = false,
    config = function()
      require("plugins.configs.zenmode")
    end,
  },
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.configs.gruvbox-material")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    -- enabled = false,
    config = function()
      require("plugins.configs.kanagawa")
    end,
  },
}
