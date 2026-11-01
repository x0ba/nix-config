return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    -- Neovim ships its own "catppuccin" colorscheme, so load the plugin
    -- before LazyVim applies its colorscheme at startup.
    priority = 10001,
    opts = {
      -- "auto" picks latte or mocha from vim.o.background.
      flavour = "auto",
      background = { light = "latte", dark = "mocha" },
      transparent_background = true,
      float = { transparent = true },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Follow the terminal background: Neovim sets 'background' from the
  -- terminal's OSC 11 reply at startup (and on resume), and changing
  -- 'background' makes Neovim reload the colorscheme. Catppuccin's "auto"
  -- flavour then selects latte or mocha. See config/autocmds.lua for the
  -- re-query on focus.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
