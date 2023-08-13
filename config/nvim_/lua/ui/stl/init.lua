local run = function(STYLE)
  local mode = require("ui.stl.modules.mode")
  local filename = require("ui.stl.modules.filename")
  local branch = require("ui.stl.modules.branch")
  local folder = require("ui.stl.modules.folder")
  local position = require("ui.stl.modules.position")
  local diagnostics = require("ui.stl.modules.diagnostics")
  local lsp = require("ui.stl.modules.lsp")
  return table.concat({
    mode(STYLE),
    filename(STYLE),
    branch(),
    "%=",
    diagnostics(STYLE),
    folder(STYLE),
    lsp(STYLE) or "",
    position(STYLE),
  })
end

local setup = function(STYLE)
  vim.opt.statusline = run(STYLE)
  vim.api.nvim_create_autocmd({ "ModeChanged", "LspAttach" }, {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      vim.opt.statusline = run(STYLE)
    end,
  })
end

return { run = run, setup = setup }
