local string = require('string')

local function nmap(sequence, command, description)
    vim.keymap.set('n', sequence, command, { silent = true, desc = description })
end
local function tmap(sequence, command, description)
    vim.keymap.set('t', sequence, command, { silent = true, desc = description })
end
local function vmap(sequence, command, description)
    vim.keymap.set('v', sequence, command, { silent = true, desc = description })
end

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch, { silent = true })

nmap('dcb', function() require("buffexit").bdelete() end, "[D]elete the [C]urrent [B]uffer")
vmap('<leader>f', function() vim.lsp.buf.format({ async = true }) end, "[F]ormat")

-- // QUICKFIX NAV
nmap('<C-j>', vim.cmd.cnext, "Quickfix next")
nmap('<C-k>', vim.cmd.cprev, "Qucikfix prev")

-- // NAVIGATION
nmap('grn', function() vim.lsp.buf.rename() end, "[G]et [R]elative re[N]ame")
nmap('fcb', function() vim.lsp.buf.format() end, "[F]ormat [C]urrent [B]uffer")
nmap('gD', function() require("fzf-lua").git_diff() end, "FZF Workspace Diagnostics")

nmap('grr', function() require("fzf-lua").lsp_references() end, "[G]et [R]elative [R]eferences")
nmap('grd', function() require("fzf-lua").lsp_definitions() end, "[G]et [R]elative [D]efinition")
nmap('gri', function() require("fzf-lua").lsp_implementations() end, "[G]et [R]elative [I]mplementation")
nmap('gra', function() require("fzf-lua").lsp_code_actions() end, "[G]et [R]elative [A]ction")
nmap('grs', function() require("fzf-lua").lsp_document_symbols() end, "[G]ets [R]elative [S]ymbols")
nmap('grx', function() require("fzf-lua").lsp_document_diagnostics() end, "[G]ets [R]elative diagnosti[X]")
nmap('<leader>rX', function() require("fzf-lua").lsp_workspace_diagnostics() end, "FZF Workspace Diagnostics")
nmap('<leader>gc', function() require("fzf-lua").git_commits() end, "FZF Workspace Diagnostics")
nmap('<leader>gb', function() require("fzf-lua").git_branches() end, "FZF Workspace Diagnostics")
nmap('<leader>gB', function() require("fzf-lua").git_blame() end, "FZF Workspace Diagnostics")
nmap('<leader>gd', function() require("fzf-lua").git_diff() end, "FZF Workspace Diagnostics")
nmap('<leader>gh', function() require("fzf-lua").git_hunks() end, "FZF Workspace Diagnostics")
nmap('<leader>gs', function() require("fzf-lua").git_status() end, "FZF Workspace Diagnostics")

nmap('<leader>t', function() require("yazi").toggle() end, 'Toggle Yazi')
nmap('<Leader>b', function() require("fzf-lua").buffers() end, "[B]uffers")
nmap('<Leader>f', function() require("fzf-lua").files() end, "[F]iles")
nmap('<C-f>', function() require("fzf-lua").files() end, "Alias of <Leader>f")
nmap('<Leader>G', function() require("fzf-lua").grep() end, "[G]rep")

nmap('<leader>[', function() require('gitsigns').nav_hunk('prev') end, "Prev Hunk")
nmap('<leader>]', function() require('gitsigns').nav_hunk('next') end, "Next Hunk")
nmap('<leader>sgh', function() require('gitsigns').stage_hunk() end, "Stage Hunk")
vmap('<leader>sgh', function() require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Stage Hunk")

nmap('<A-f>', function() require("toggleterm").toggle(nil, nil, nil, "float", "Float Term") end, "Toggle Floating term")
tmap('<A-f>', function() require("toggleterm").toggle(nil, nil, nil, "float", "Float Term") end, "Toggle Floating term")

tmap('<Esc>', [[<C-\><C-n>]], "Exit terminal")

return {}
