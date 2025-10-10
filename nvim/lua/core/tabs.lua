return {
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('barbar').setup {
                animation = false,
                tabpages = false,
                clickable = false,
                icons = {
                    filetype = {
                        enabled = false,
                    }
                },
                auto_hide = 1,
            }
        end
    },
}
