-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Re-query the terminal's background color when Neovim regains focus, so a
-- light/dark switch in the terminal is picked up without restarting. The TUI
-- updates 'background' from the OSC 11 reply, which reloads the colorscheme.
vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Refresh 'background' from the terminal",
  callback = function()
    if #vim.api.nvim_list_uis() > 0 then
      pcall(vim.api.nvim_ui_send, "\27]11;?\7")
    end
  end,
})

-- Reflow prose to 80 columns when saving.
--
-- Only the filetypes in this table are touched, so code is never reflowed.
--   ts:    reflow only treesitter "paragraph" nodes, leaving fenced code,
--          tables, frontmatter, setext headings, etc. alone.
--   whole: reflow the whole buffer (plain text).
local prose = {
  markdown = { ts = "markdown" },
  ["markdown.mdx"] = { ts = "markdown" },
  text = { whole = true },
}

local wrap_group = vim.api.nvim_create_augroup("user_wrap_on_save", { clear = true })

-- Respect LazyVim's <leader>uf / <leader>uF autoformat toggles.
local function autoformat_enabled(buf)
  local baf = vim.b[buf].autoformat
  if baf ~= nil then
    return baf
  end
  return vim.g.autoformat == nil or vim.g.autoformat
end

local function format_range(first, last)
  vim.api.nvim_win_set_cursor(0, { first, 0 })
  vim.cmd(("silent keepjumps normal! gq%dG"):format(last))
end

-- Paragraph ranges for a treesitter language, bottom-up so that reflowing one
-- paragraph does not invalidate the line numbers of the next.
local function paragraph_ranges(buf, lang)
  local ok, parser = pcall(vim.treesitter.get_parser, buf, lang)
  if not ok then
    return {}
  end

  local ok_tree, tree = pcall(function()
    return parser:parse()[1]
  end)
  if not ok_tree or not tree then
    return {}
  end

  local ok_query, query = pcall(vim.treesitter.query.parse, lang, "(paragraph) @paragraph")
  if not ok_query then
    return {}
  end

  local ranges = {}
  for _, node in query:iter_captures(tree:root(), buf, 0, -1) do
    -- A setext heading's underline must stay directly below its text, so
    -- wrapping that "paragraph" would break the heading.
    local skip = false
    local parent = node:parent()
    while parent do
      if parent:type() == "setext_heading" then
        skip = true
        break
      end
      parent = parent:parent()
    end

    if not skip then
      local sr, _, er, ec = node:range()
      local first = sr + 1
      local last = (ec == 0 and er > sr) and er or (er + 1)
      ranges[#ranges + 1] = { first, math.max(first, last) }
    end
  end

  table.sort(ranges, function(a, b)
    return a[1] > b[1]
  end)
  return ranges
end

local function reflow(buf)
  local spec = prose[vim.bo[buf].filetype]
  if not spec then
    return
  end

  -- LazyVim points 'formatexpr' at conform/LSP, so gq would run that formatter
  -- instead of Vim's own line wrapping. Its treesitter 'indentexpr' also
  -- overrides the indentation gq gives continuation lines (e.g. list items).
  local formatexpr = vim.bo[buf].formatexpr
  local indentexpr = vim.bo[buf].indentexpr
  vim.bo[buf].formatexpr = ""
  vim.bo[buf].indentexpr = ""
  local view = vim.fn.winsaveview()

  pcall(function()
    if spec.whole then
      format_range(1, vim.api.nvim_buf_line_count(buf))
    else
      for _, range in ipairs(paragraph_ranges(buf, spec.ts)) do
        format_range(range[1], range[2])
      end
    end
  end)

  vim.fn.winrestview(view)
  vim.bo[buf].formatexpr = formatexpr
  vim.bo[buf].indentexpr = indentexpr
end

vim.api.nvim_create_autocmd("FileType", {
  group = wrap_group,
  pattern = vim.tbl_keys(prose),
  desc = "Wrap prose at 80 columns",
  callback = function(args)
    vim.bo[args.buf].textwidth = 80
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = wrap_group,
  desc = "Reflow prose to 'textwidth' before saving",
  callback = function(args)
    local buf = args.buf
    if not prose[vim.bo[buf].filetype] then
      return
    end
    if not autoformat_enabled(buf) or not vim.bo[buf].modified then
      return
    end
    if buf ~= vim.api.nvim_get_current_buf() then
      return
    end

    vim.bo[buf].textwidth = 80
    reflow(buf)
  end,
})
