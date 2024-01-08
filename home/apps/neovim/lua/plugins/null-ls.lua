---@type LazyPluginSpec[]
return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local nls = require("null-ls")
      local builtins = nls.builtins
      return {
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".neoconf.json",
          "Makefile",
          ".git"
        ),
        sources = {
          builtins.formatting.stylua,
          builtins.formatting.shfmt,

          builtins.code_actions.statix,
          builtins.formatting.nixpkgs_fmt,

          builtins.formatting.rustfmt,

          -- builtins.formatting.clang_format
        },
      }
    end,
  },
}
