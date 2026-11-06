-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "80"
-- 'textwidth' is set per filetype in config/autocmds.lua, so only prose is
-- wrapped and code is left alone.
vim.opt.wrap = true
vim.opt.linebreak = true -- soft-wrap at word boundaries
vim.opt.breakindent = true -- keep indentation on wrapped lines
