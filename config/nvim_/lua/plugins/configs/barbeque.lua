return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    enabled = true,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      symbols = {
        modified = "●",
        ellipsis = "…",
        separator = "",
      },
    },
  },
}
