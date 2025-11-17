return {
    {
        "mikavilpas/yazi.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {
            floating_window_scaling_factor = 0.75,
            open_for_directories = true,
            keymap = { show_help = "<f1>" }
        },
        init = function()
            vim.g.loaded_netrwPlugin = 1
        end
    }
}
