return {
	"NeogitOrg/neogit",
	dependencies = "nvim-lua/plenary.nvim",
	lazy = true,
	cmd = "Neogit",
	config = function()
		local neogit = require("neogit")
		neogit.setup({})
	end,
}
