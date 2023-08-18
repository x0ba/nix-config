return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {},
				rust_analyzer = {},
				html = {},
				cssls = {},
				tsserver = {},
				ccls = { offset_encoding = "utf-8" },
				nil_ls = {},
			},
		},
	},
}
