return {
    {
        "ibhagwan/fzf-lua",
        config = function()
            require('fzf-lua').setup {
                preview = {
                    default = 'bat'
                }
            }
        end
    }
}
