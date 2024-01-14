---@type LazyPluginSpec[]
return {
  {
    "lmburns/lf.nvim",
    dependencies = "akinsho/toggleterm.nvim",
    config = function()
      vim.g.lf_netrw = 1

      require("lf").setup({
        escape_quit = false,
        border = "rounded",
      })
    end,
  },
}
