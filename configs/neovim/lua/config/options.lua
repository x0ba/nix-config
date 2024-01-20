vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = "yes"
vim.wo.conceallevel = 2

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

if vim.g.neovide then
	vim.o.guifont = "Fira Code,Symbols Nerd Font:h17:h15"
	vim.opt.linespace = 2
end
