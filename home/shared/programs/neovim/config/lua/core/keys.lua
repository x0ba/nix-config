vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap

map("n", "j", "gj", { noremap = false, silent = false })
map("n", "k", "gk", { noremap = false, silent = false })

map("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("n", "<C-f>", ":lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })
map("n", "<C-\\>", ":ToggleTerm<CR>", { noremap = true, silent = true })

map("n", "<leader>gg", ":Neogit<CR>", { noremap = true, silent = true })

map("n", "zR", ':lua require("ufo").openAllFolds<CR>', { noremap = true, silent = true })
map("n", "zM", ':lua require("ufo").closeAllFolds<CR>', { noremap = true, silent = true })

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-y>", function()
    ui.nav_file(1)
end)
vim.keymap.set("n", "<C-t>", function()
    ui.nav_file(2)
end)
vim.keymap.set("n", "<C-n>", function()
    ui.nav_file(3)
end)
vim.keymap.set("n", "<C-s>", function()
    ui.nav_file(4)
end)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
