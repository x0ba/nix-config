vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap

-- file trees are overrated
map("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- telescope mappings
map(
  "n",
  "<leader>ff",
  ":Telescope find_files<CR>",
  { noremap = true, silent = true }
)
map(
  "n",
  "<leader>fg",
  ":Telescope live_grep<CR>",
  { noremap = true, silent = true }
)
map(
  "n",
  "<leader>fp",
  ":Telescope project<CR>",
  { noremap = true, silent = true }
)
map(
  "n",
  "<leader><leader>",
  ":Telescope buffers<CR>",
  { noremap = true, silent = true }
)

-- track.nvim mappings
map("n", "<leader>a", ":TrackMark<CR>", { noremap = true, silent = true })
map("n", "<C-e>", ":Track<CR>", { noremap = true, silent = true })

-- c-f to format the buffer
map(
  "n",
  "<C-f>",
  ":lua vim.lsp.buf.format()<CR>",
  { noremap = true, silent = true }
)

-- why no default split keys :sob:
map("n", "<Leader>wv", ":vsplit<CR>", { silent = true })
map("n", "<Leader>wh", ":split<CR>", { silent = true })

-- Neogit
map("n", "<Leader>gs", ":Neogit<CR>", { silent = true })

vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")

map("n", "<Leader>u", ":UndotreeToggle<CR>", { silent = true })

map("n", "<Leader>t", ":ToggleTerm<CR>", { silent = true })

-- bufferline
map("n", "<tab>", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "<C-tab>", ":BufferLineCyclePrev<CR>", { silent = true })

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

-- folds
map(
  "n",
  "zR",
  ':lua require("ufo").openAllFolds<CR>',
  { noremap = true, silent = true }
)
map(
  "n",
  "zM",
  ':lua require("ufo").closeAllFolds<CR>',
  { noremap = true, silent = true }
)

-- remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

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
