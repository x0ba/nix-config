vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

map('n', 'j', 'gj', { noremap = false, silent = false })
map('n', 'k', 'gk', { noremap = false, silent = false })

map('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
map('n', '<C-f>', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
map('n', '<C-\\>', ':ToggleTerm<CR>', { noremap = true, silent = true })

map('n', '<leader>gg', ':Neogit<CR>', { noremap = true, silent = true })

map('n', 'zR', ':lua require("ufo").openAllFolds<CR>', { noremap = true, silent = true })
map('n', 'zM', ':lua require("ufo").closeAllFolds<CR>', { noremap = true, silent = true })
