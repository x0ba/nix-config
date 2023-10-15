return {
  "max397574/better-escape.nvim",
  opts = {
    mapping = { "jk", "jj" },
    timeout = vim.o.timeoutlen,
    clear_empty_lines = false,
    keys = "<Esc>",
  },
  lazy = true,
  event = { "CmdlineEnter", "InsertEnter", "CursorHold", "CursorMoved" },
}
