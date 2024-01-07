---@type LazyPluginSpec[]
return {
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  -- {
  --   "catppuccin/nvim",
  --   lazy = true,
  --   name = "catppuccin",
  --   opts = {
  --     term_colors = true,
  --     transparent_background = false,
  --     styles = {
  --       comments = {},
  --       conditionals = {},
  --       loops = {},
  --       functions = {},
  --       keywords = {},
  --       strings = {},
  --       variables = {},
  --       numbers = {},
  --       booleans = {},
  --       properties = {},
  --       types = {},
  --     },
  --     integrations = {
  --       telescope = {
  --         enabled = true,
  --         style = "nvchad",
  --       },
  --       treesitter_context = {
  --         enabled = true,
  --       },
  --       dropbar = {
  --         enabled = true,
  --         color_mode = true,
  --       },
  --       harpoon = {
  --         enabled = true,
  --       },
  --       fidget = {
  --         enabled = true,
  --       },
  --     },
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },
}
