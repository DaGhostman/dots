local function nmap(sequence, command, description)
    vim.keymap.set('n', sequence, command, { silent = true, desc = description })
end
local function tmap(sequence, command, description)
    vim.keymap.set('t', sequence, command, { silent = true, desc = description })
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

nmap('<leader>rr', function() require("fzf-lua").lsp_references() end, "FZF References")
nmap('<leader>rd', function() require("fzf-lua").lsp_definitions() end, "FZF Definitions")
nmap('<leader>ri', function() require("fzf-lua").lsp_implementations() end, "FZF Implementations")
nmap('<leader>ra', function() require("fzf-lua").lsp_code_actions() end, "FZF Document Symbols")
nmap('<leader>rs', function() require("fzf-lua").lsp_document_symbols() end, "FZF Document Symbols")
nmap('<leader>rx', function() require("fzf-lua").lsp_document_diagnostics() end, "FZF Document Diagnostics")
nmap('<leader>rX', function() require("fzf-lua").lsp_workspace_diagnostics() end, "FZF Workspace Diagnostics")

nmap('<leader>t', function() require("yazi").toggle() end, 'Toggle Yazi')
nmap('<Leader>b', function() require("fzf-lua").buffers() end, "[B]uffers")
nmap('<Leader>f', function() require("fzf-lua").files() end, "[F]iles")
nmap('<C-f>', function() require("fzf-lua").files() end, "Alias of <Leader>f")
nmap('<Leader>g', function() require("fzf-lua").grep() end, "[G]rep")

nmap('<Leader>ha', function() require("harpoon"):list():add() end, "[H]arpoon [A]dd")
nmap('<Leader>hl', function()
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, "[H]arpoon [A]dd")
nmap('<Leader>h1', function() require("harpoon"):list():select(1) end, "[H]arpoon switch to [1]")
nmap('<Leader>h2', function() require("harpoon"):list():select(2) end, "[H]arpoon switch to [2]")
nmap('<Leader>h3', function() require("harpoon"):list():select(3) end, "[H]arpoon switch to [3]")
nmap('<Leader>h4', function() require("harpoon"):list():select(4) end, "[H]arpoon switch to [4]")
nmap('<Leader>h5', function() require("harpoon"):list():select(5) end, "[H]arpoon switch to [5]")
nmap('<Leader>h6', function() require("harpoon"):list():select(6) end, "[H]arpoon switch to [6]")
nmap('<Leader>h7', function() require("harpoon"):list():select(7) end, "[H]arpoon switch to [7]")
nmap('<Leader>h8', function() require("harpoon"):list():select(8) end, "[H]arpoon switch to [8]")
nmap('<Leader>h9', function() require("harpoon"):list():select(9) end, "[H]arpoon switch to [9]")
nmap('<Leader>h0', function() require("harpoon"):list():select(0) end, "[H]arpoon switch to [0]")
nmap('<C-h>', function() require("harpoon"):list():prev() end, "[H]arpoon [P]rev")
nmap('<C-l>', function() require("harpoon"):list():next() end, "[H]arpoon [N]ext")

nmap('<A-f>', function() require("toggleterm").toggle(nil, nil, nil, "float", "Float Term") end, "Toggle Floating term")
tmap('<A-f>', function() require("toggleterm").toggle(nil, nil, nil, "float", "Float Term") end, "Toggle Floating term")

return {}
