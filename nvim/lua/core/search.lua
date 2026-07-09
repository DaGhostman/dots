return {
    {
        "ibhagwan/fzf-lua",
        config = function()
            require('fzf-lua').setup {
                preview = {
                    default = 'bat'
                },
                winopts = {
                    preview = {
                        layout = "vertical",
                        vertical = "down:80%"
                    }
                }
            }
        end
    }
}
