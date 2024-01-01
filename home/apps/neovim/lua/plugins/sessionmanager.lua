return {
  "Shatur/neovim-session-manager",
  config = function()
    require("session_manager").setup({
      autoload_mode = "CurrentDir",
    })
  end,
}
