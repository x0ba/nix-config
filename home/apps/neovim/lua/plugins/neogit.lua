return {
  "NeogitOrg/neogit",
  lazy = true,
  cmd = "Neogit",
  config = function()
    local neogit = require("neogit")
    neogit.setup({})
  end,
}
