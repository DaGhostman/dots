vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(ev)
        local excluded = {}

        for _, suffix in pairs(excluded) do
            if string.sub(ev.file, -#suffix) == suffix then

                return nil
            end
        end

        vim._with({ silent = true }, vim.lsp.buf.format)
    end
})

vim.api.nvim_create_autocmd("Termopen", {
    callback=function() 
        vim.wo[0][0].scrolloff = 0
    end
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufAdd'}, {
    pattern = '*.http',
    callback = function()
        vim.keymap.set('n', '<C-e>', function()
            vim.cmd('Rest run')
        end, { silent = true, noremap = true, buffer = true });
    end,
})

return {}
