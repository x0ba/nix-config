return {
  -- { -- Theme inspired by Atom
  --   "notken12/base46-colors",
  --   priority = 1000,
  -- },
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        term_colors = true,
        transparent_background = false,
        no_italic = false,
        no_bold = false,
        styles = {
          comments = {},
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
        },
        color_overrides = {
          mocha = {
            base = "#11111b",
            mantle = "#11111b",
            crust = "#11111b",
          },
        },
        highlight_overrides = {
          mocha = function(C)
            return {
              TabLineSel = { bg = C.pink },
              CmpBorder = { fg = C.surface2 },
              Pmenu = { bg = C.none },
              TelescopeBorder = { link = "FloatBorder" },
            }
          end,
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
