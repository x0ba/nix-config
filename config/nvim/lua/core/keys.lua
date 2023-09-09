vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap

-- file trees are overrated
map('n', '<C-b>', ':Oil<CR>', { noremap = true, silent = true })

-- telescope mappings
map('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
map('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
map('n', '<C-f>', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- why no default split keys :sob:
map("n", "<Leader>wv", ":vsplit<CR>", { silent = true })
map("n", "<Leader>wh", ":split<CR>", { silent = true })

-- neogit
map("n", "<Leader>gg", ":Neogit<CR>", { silent = true })

map("n", "<Leader>u", ":UndotreeToggle<CR>", { silent = true })

map("n", "<Leader>t", ":ToggleTerm<CR>", { silent = true })

-- bufferline
map("n", "<tab>", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "<C-tab>", ":BufferLineCyclePrev<CR>", { silent = true })
map("n", "<C-x>", ":BufferLineCloseLeft<CR>", { silent = true })

-- diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- folds
map('n', 'zR', ':lua require("ufo").openAllFolds<CR>', { noremap = true, silent = true })
map('n', 'zM', ':lua require("ufo").closeAllFolds<CR>', { noremap = true, silent = true })
