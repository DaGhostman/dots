vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch, { silent = true })

vim.keymap.set('n', 'bd', function() require("buffexit").bdelete() end, { silent = true })

vim.keymap.set('n', '<A-,>', function() require('barbar').previous() end, { silent = true })
vim.keymap.set('n', '<A-.>', function() require('barbar').next() end, { silent = true })

-- // QUICKFIX NAV
vim.keymap.set('n', '<C-j>', vim.cmd.cnext, { silent = true })
vim.keymap.set('n', '<C-k>', vim.cmd.cprev, { silent = true })

-- // NAVIGATION
vim.keymap.set('n', 'grr', function() vim.lsp.buf.references() end, { silent = true })
vim.keymap.set('n', 'grd', function() vim.lsp.buf.definition() end, { silent = true })
vim.keymap.set('n', 'gri', function() vim.lsp.buf.implementation() end, { silent = true })
vim.keymap.set('n', 'gra', function() vim.lsp.buf.code_action() end, { silent = true })
vim.keymap.set('n', 'grn', function() vim.lsp.buf.rename() end, { silent = true })
vim.keymap.set('n', 'grb', function() require("fzf-lua").buffers() end, { silent = true })
vim.keymap.set('n', 'grf', function() require("fzf-lua").files() end, { silent = true })
vim.keymap.set('n', 'grg', function() require("fzf-lua").grep() end, { silent = true })

return {}
