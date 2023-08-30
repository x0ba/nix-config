-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- splits
map("n", "<Leader>wv", ":vsplit<CR>", { silent = true })
map("n", "<Leader>hv", ":split<CR>", { silent = true })

-- neogit
map("n", "<Leader>gg", ":Neogit<CR>", { silent = true })

-- remaps

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Undotree remap
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>e", ":RnvimrToggle<CR>")

-- Lazyvim overrides c-hjkl
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
