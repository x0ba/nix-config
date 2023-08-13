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
