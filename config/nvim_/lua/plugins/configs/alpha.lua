return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
 ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██
▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░     ░░   ▒ ░░      ░
         ░      ░   ░         ░
               ░
    ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", "<cmd>ene<cr>"),
        dashboard.button("f", "  Search for file", "<cmd>Telescope find_files<cr>"),
        dashboard.button("r", "  Open recent file", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("n", "  Open file explorer", "<cmd>neotree<cr>"),
        dashboard.button("u", "  Update plugins", "<cmd>Lazy update<cr>"),
        dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          -- dashboard.section.footer.val = "Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
