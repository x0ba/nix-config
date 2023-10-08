require("plugs.strap")
require("lazy").setup({
  "christoomey/vim-tmux-navigator",
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
    dependencies = {
      { "williamboman/mason.nvim", event = "VeryLazy", config = true },
      {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        tag = "legacy",
        config = true,
      },
      { "folke/neodev.nvim", event = "VeryLazy", opts = {} },
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    -- tag = 'v2.20.8',
    config = function()
      require("plugs.ui.lualine")
    end,
  },
  {
    "wakatime/vim-wakatime",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
    event = { "BufRead" },
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugs.lsp.conform")
    end,
  },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk", "jj" },
      timeout = vim.o.timeoutlen,
      clear_empty_lines = false,
      keys = "<Esc>",
    },
    lazy = true,
    event = { "CmdlineEnter", "InsertEnter", "CursorHold", "CursorMoved" },
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
  },
  {
    "Shatur/neovim-session-manager",
    lazy = true,
    cmd = "SessionManager",
    opts = { autoload_mode = "CurrentDir" },
  },
  {
    "LnL7/vim-nix",
    lazy = true,
    ft = "nix",
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("plugs.ui.bufferline")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("plugs.ui.colorizer")
    end,
    lazy = true,
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    config = function()
      require("plugs.util.toggleterm")
    end,
    cmd = "ToggleTerm",
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("plugs.lsp.saga")
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "G", "Git", "Gread", "Gwrite", "Gvdiffsplit" },
  },
  {
    "mbbill/undotree",
    lazy = true,
    cmd = { "UndotreeToggle" },
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugs.ui.alpha")
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "o", "x" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          require("plugs.lsp.luasnip")
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        event = "InsertEnter",
        lazy = true,
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done()
          )
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    config = function()
      require("plugs.lsp.cmp")
    end,
  },

  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    keys = { "<leader>", " ", "'", "`" },
    lazy = true,
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufRead" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "│",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "│",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = "_",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = "‾",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = "~",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          untracked = {
            hl = "GitSignsAdd",
            text = "│",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsDeleteLn",
          },
        },
      })
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("oxocarbon")
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },

    event = "InsertEnter",
    lazy = true,
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  -- "gc" to comment visual regions/lines
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = true,
    event = { "BufRead" },
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    lazy = true,
    dependencies = {
      { "plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      require("plugs.util.telescope")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    event = "BufRead",
    config = function()
      require("plugs.ui.devicons")
    end,
    lazy = true,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugs.util.oil")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    lazy = true,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      require("plugs.ts.treesitter")
    end,
  },
})
