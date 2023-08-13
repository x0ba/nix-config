local wk = require("which-key")
wk.setup({})

local mappings = {
  q = {
    name = "File",
    q = { ":q<cr>", "Quit" },
    w = { ":wq<cr>", "Save & Quit" },
    s = { ":w<cr>", "Save" },
    f = { ":lua vim.lsp.buf.format()<CR>", "Format file" },
    x = { ":bdelete<cr>", "Close" },
  },
  f = {
    name = "Telescope",
    f = { ":Telescope find_files<cr>", "Find Files" },
    r = { ":Telescope oldfiles<cr>", "Recently Opened" },
    g = { ":Telescope live_grep<cr>", "Find String" },
    p = { ":Telescope project<cr>", "Find Project" },
    c = {
      ":lua require('themes.schemer').setup(require('telescope.themes').get_dropdown{})<cr>",
      "Change Colorschemes",
    },
  },
  t = {
    name = "Terminal",
    t = { ":ToggleTerm<cr>", "Split Below" },
  },
  l = {
    name = "Misc",
    l = { ":Lazy<cr>", "Open Lazy" },
    c = { ":lua require('telescope') vim.lsp.buf.code_action()<cr>", "Show Code Actions" },
    m = { ":Mason<cr>", "Open Mason" },
    s = { ":SymbolsOutline<cr>", "Overview of file" },
    w = { ":SessionSave<cr>", "Save this session" },
  },
}

local opts = { prefix = "<leader>" }
wk.register(mappings, opts)
