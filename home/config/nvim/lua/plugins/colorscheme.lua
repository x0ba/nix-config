return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    opts = {
      -- Follow vim.o.background, which Neovim sets from the terminal.
      -- Level 2 clears the editor background and the statusline fill.
      -- "blend" gives floating windows that same transparent background.
      transparent_background_level = 1,
      float_style = "blend",
    },
    config = function(_, opts)
      require("everforest").setup(opts)
      vim.cmd.colorscheme("everforest")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
