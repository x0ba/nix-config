return {
  {
    "nvim-lualine/lualine.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin-frappe",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "searchcount" },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        tabline = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
}
