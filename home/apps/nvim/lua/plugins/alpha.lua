return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      "                                              ",
      "       ███████████           █████      ██",
      "      ███████████             █████ ",
      "      ████████████████ ███████████ ███   ███████",
      "     ████████████████ ████████████ █████ ██████████████",
      "    ██████████████    █████████████ █████ █████ ████ █████",
      "  ██████████████████████████████████ █████ █████ ████ █████",
      " ██████  ███ █████████████████ ████ █████ █████ ████ ██████",
    }
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":ene <bar> startinsert <cr>"),
      dashboard.button("SPC ff", "  Find file", ":Telescope find_files<cr>"),
      dashboard.button("SPC fg", "  Live grep", ":Telescope live_grep<cr>"),
      dashboard.button(
        "s",
        "  Show sessions",
        ':lua require("persistence").load()<cr>'
      ),
      dashboard.button("SPC fp", "  Projects", ":Telescope project<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }
    local version = vim.version()
    dashboard.section.footer.val = "neovim v"
      .. version.major
      .. "."
      .. version.minor
      .. "."
      .. version.patch
      .. "      "
      .. require("lazy").stats().count
      .. " plugins"
    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end,
}
