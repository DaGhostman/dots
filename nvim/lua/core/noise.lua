return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("notify").setup({
                merge_duplicates = true,
                background_colour = "#000000",
            })
            require("noice").setup({
                cmdline = {
                    view = "cmdline",
                    format = {
                        cmdline = {
                            icon = ""
                        }
                    }
                },
                lsp = {
                    override = {
                        ["nvim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["nvim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    }
                },
                presets = {
                    bottom_search = true,
                    command_palette = false,
                    long_message_to_split = true,
                    lsp_doc_border = true,
                }
            })
        end
    }
}
