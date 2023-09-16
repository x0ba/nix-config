---@diagnostic disable: undefined-global

files["home/apps/nvim"] = {
  globals = { "vim" },
  std = "lua51+luajit",
}

return {
  exclude_files = {
    ".direnv/*",
    "result/*",
  },
  max_line_length = false,
}
