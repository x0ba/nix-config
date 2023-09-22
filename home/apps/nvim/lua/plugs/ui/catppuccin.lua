require("catppuccin").setup({
  transparent_background = not vim.g.neovide,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
  },
  term_colors = true,
  integrations = {
    treesitter = true,
    treesitter_context = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    cmp = true,
    lsp_trouble = true,
    nvimtree = true,
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    navic = {
      enabled = true,
      custom_bg = "NONE",
    },
    gitsigns = true,
    lightspeed = true,
    markdown = true,
    neogit = true,
    symbols_outline = true,
    ts_rainbow = true,
    vimwiki = true,
    notify = true,
  },
  highlight_overrides = {
    all = function(colors)
      local c = {
        -- borders
        FloatBorder = { fg = colors.overlay0 },
        LspInfoBorder = { link = "FloatBorder" },
        NvimTreeWinSeparator = { link = "FloatBorder" },
        WhichKeyBorder = { link = "FloatBorder" },
        -- telescope
        TelescopeBorder = { link = "FloatBorder" },
        TelescopeTitle = { fg = colors.text },
        TelescopeSelection = { link = "Selection" },
        TelescopeSelectionCaret = { link = "Selection" },
        -- pmenu
        PmenuSel = { link = "Selection" },
        -- bufferline
        BufferLineTabSeparator = { link = "FloatBorder" },
        BufferLineSeparator = { link = "FloatBorder" },
        BufferLineOffsetSeparator = { link = "FloatBorder" },
        --
        FidgetTitle = { fg = colors.subtext1 },
        FidgetTask = { fg = colors.subtext0 },

        NotifyBackground = { bg = colors.base },
        NotifyINFOBorder = { link = "NotifyInfoTitle" },
        NotifyINFOIcon = { link = "NotifyINFOTitle" },
        NotifyINFOTitle = { fg = colors.pink },
      }

      local U = require("catppuccin.utils.colors")
      for i = 1, 20, 1 do
        c = vim.tbl_extend("keep", c, {
          ["HeaderGradient" .. i] = {
            fg = U.blend(colors.mauve, colors.pink, i / 20),
          },
        })
      end
      return c
    end,
  },
})

vim.cmd.colorscheme("catppuccin")
