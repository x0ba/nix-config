---@type LazyPluginSpec[]
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				color_overrides = {
					macchiato = {
						text = "#c5c8c9",
						base = "#131a1c",
						mantle = "#192022",
						crust = "#202729",
						surface0 = "#202729",
						surface1 = "#363d3e",
						surface2 = "#4a5051",
					},
				},
				integrations = {
					telescope = {
						enabled = true,
						style = "nvchad",
					},
				},
			})
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin-macchiato",
		},
	},
}
