local nnoremap = require('lukeo.keymap').nnoremap
local inoremap = require('lukeo.keymap').inoremap

-- Basic stuff
inoremap('jk', '<C-c>')

-- Splits
nnoremap('<leader>v', '<C-w>v')
nnoremap('<leader>s', '<C-w>s')
nnoremap('<leader>q', '<C-w>q')
nnoremap('<leader>h', '<C-w>h')
nnoremap('<leader>l', '<C-w>l')
nnoremap('<leader>j', '<C-w>j')
nnoremap('<leader>k', '<C-w>k')
nnoremap('>', '<C-w>>')
nnoremap('<', '<C-w><')
nnoremap('+', '<C-w>+')
nnoremap('-', '<C-w>-')
nnoremap('=', '<C-w>=')

-- netrw
nnoremap('<leader>ex', '<cmd>Ex<CR>')

nnoremap('<leader>x', vim.diagnostic.open_float)
