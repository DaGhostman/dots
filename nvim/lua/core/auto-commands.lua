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


return {}
