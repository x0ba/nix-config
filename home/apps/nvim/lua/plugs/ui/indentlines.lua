vim.opt.list = true
vim.opt.listchars:append 'space:⋅'

local highlight = {
  'CursorColumn',
  'Whitespace',
}
require('ibl').setup {
  indent = { highlight = highlight, char = '' },
  whitespace = {
    -- highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = false },
}
