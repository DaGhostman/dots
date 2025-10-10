return {
    {
        "Shatur/neovim-session-manager",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local session = require('session_manager')
            local config = require("session_manager.config")

            session.setup { autoload_mode = config.AutoloadMode.CurrentDir }

            vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
                callback = function()
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_get_option_value('buftype', { buf = buf }) == "nofile" then
                            return
                        end
                    end

                    session.save_current_session()
                end
            })
        end
    }
}
