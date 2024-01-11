local map = vim.api.nvim_set_keymap

-- file trees are overrated
map("n", "<C-b>", ":Lf<CR>", { noremap = true, silent = true })

-- telescope stuff
map(
  "n",
  "<leader>fb",
  ":Telescope buffers<CR>",
  { noremap = true, silent = true }
)

-- spectre mappings
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
vim.keymap.set(
  "n",
  "<leader>sw",
  '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
  {
    desc = "Search current word",
    remap = true,
  }
)
vim.keymap.set(
  "v",
  "<leader>sw",
  '<esc><cmd>lua require("spectre").open_visual()<CR>',
  {
    desc = "Search current word",
    remap = true,
  }
)
vim.keymap.set(
  "n",
  "<leader>sp",
  '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
  {
    desc = "Search on current file",
    remap = true,
  }
)

-- keep cursor in the middle when scrolling and searching
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
map("n", "n", "nzzzv", { noremap = true, silent = true })
map("n", "N", "Nzzzv", { noremap = true, silent = true })

-- why no default split keys :sob:
map("n", "<Leader>wv", ":vsplit<CR>", { silent = true })
map("n", "<Leader>wh", ":split<CR>", { silent = true })

-- Neogit
map("n", "<Leader>gg", ":Neogit<CR>", { noremap = true, silent = true })

-- Gitsigns
vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")

-- buffers
map("n", "H", ":bprevious<CR>", { silent = true })
map("n", "L", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":bd<CR>", { silent = true, remap = true })

-- diagnostics
vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { desc = "Go to previous diagnostic message" }
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { desc = "Go to next diagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Open floating diagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostics list" }
)

-- remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>yy", [["+yy]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
