-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Re-query the terminal's background color when Neovim regains focus, so a
-- light/dark switch in the terminal is picked up without restarting. The TUI
-- updates 'background' from the OSC 11 reply, which reloads the colorscheme.
vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Refresh 'background' from the terminal",
  callback = function()
    if #vim.api.nvim_list_uis() > 0 then
      pcall(vim.api.nvim_ui_send, "\27]11;?\7")
    end
  end,
})
