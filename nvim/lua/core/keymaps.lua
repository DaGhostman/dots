local function nmap(sequence, command, description)
    vim.keymap.set('n', sequence, command, { silent = true, desc = description })
end

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch, { silent = true })

nmap('dcb', function() require("buffexit").bdelete() end, "[D]elete the [C]urrent [B]uffer")

-- // QUICKFIX NAV
nmap('<C-j>', vim.cmd.cnext, "Quickfix next")
nmap('<C-k>', vim.cmd.cprev, "Qucikfix prev")

-- // NAVIGATION
nmap('grr', function() vim.lsp.buf.references() end, "[G]et [R]elative [R]eferences")
nmap('grd', function() vim.lsp.buf.definition() end, "[G]et [R]elative [D]efinition")
nmap('gri', function() vim.lsp.buf.implementation() end, "[G]et [R]elative [I]mplementation")
nmap('gra', function() vim.lsp.buf.code_action() end, "[G]et [R]elative [A]ction")
nmap('grn', function() vim.lsp.buf.rename() end, "[G]et [R]elative re[N]ame")
nmap('gds', function() vim.lsp.buf.document_symbol() end, "[G]ets [D]ocument [S]ymbols")

nmap('<Leader>b', function() require("fzf-lua").buffers() end, "[B]uffers")
nmap('<Leader>f', function() require("fzf-lua").files() end, "[F]iles")
nmap('<C-f>', function() require("fzf-lua").files() end, "Alias of <Leader>f")
nmap('<Leader>g', function() require("fzf-lua").grep() end, "[G]rep")

return {}
