vim.g.mapleader = ' '
local keymap = vim.keymap

keymap.set('n', '<leader>q', '<cmd>q<cr>')
keymap.set('n', '<leader>w', '<cmd>w<cr>')
keymap.set('n', '<leader>x', '<cmd>x<cr>')

keymap.set('n', '<c-a>', 'gg<S-v>G')

keymap.set('n', '<leader>s', ':vsplit<Return><C-w>w', { silent = true })
keymap.set('n', 'f', '<C-w>w')

keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

-- nvim-tree
keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
keymap.set('n', '<leader>l', '<cmd>:tabNext<cr>')
keymap.set('n', '<leader>.', '<cmd>:tabclose<cr>')


-- lsp
-- keymap.set('n', '<leader>o', '<cmd>TypescriptOrganizeImports<cr>')
-- keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')
-- keymap.set('n', '<leader>r', '<cmd>TypescriptRemoveUnused<cr>')
