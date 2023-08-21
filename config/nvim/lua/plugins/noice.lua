return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            progress = {
                format = {
                    {
                        "{progress} ",
                        key = "progress.percentage",
                        contents = {
                            { "{data.progress.message} " },
                        },
                    },
                    "({data.progress.percentage}%) ",
                    { "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
                    { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
                    { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
                },
                format_done = {
                    { " ", hl_group = "NoiceLspProgressSpinner" },
                    { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
                    { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
                },
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        cmdline = {
            enabled = true,
            view = "cmdline_popup",
            format = {
                cmdline = { pattern = "^:", icon = "  ", lang = "vim" },
                search_down = { kind = "search", pattern = "^/", icon = "   ", lang = "regex" },
                search_up = { kind = "search", pattern = "^%?", icon = "   ", lang = "regex" },
                lua = false,
                filter = false,
                help = false,
                input = {},
            },
        },
        presets = {
            lsp_doc_border = true,
        },
        notify = {
            enabled = false,
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 5,
                    col = "50%",
                },
                size = {
                    width = 80,
                    height = "auto",
                },
            },
        },
        format = {
            spinner = {
                name = "triangle",
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
}
