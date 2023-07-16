local keymap = vim.keymap

keymap.set('n', '<leader>q', '<cmd>q<cr>')
keymap.set('n', '<leader>w', '<cmd>w<cr>')
keymap.set('n', '<leader>x', '<cmd>x<cr>')

keymap.set('n', '<c-a>', 'gg<S-v>G')
keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>")
keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")

-- make test for golang
-- keymap.set("n", "<leader>gt", "<cmd>GoTests<CR>")

-- presentation
keymap.set("n", "<leader>pp", "<cmd>PresentingStart<CR>")
keymap.set("n", "n", "<cmd>PresentingNext<CR>")
keymap.set("n", "b", "<cmd>PresentingPrev<CR>")

-- Hop
keymap.set("n", "<leader>H", "<cmd>HopAnywhere<CR>", { silent = true })
keymap.set("n", "<leader>h", "<cmd>HopWord<CR>", { silent = true })

-- NavBuddy
keymap.set("n", "<leader>N", "<cmd>Navbuddy<CR>", { silent = true })

-- ZenMode
keymap.set("n", "<leader>Z", "<cmd>ZenMode<CR>", { silent = true })

-- Wiki
keymap.set("n", "<leader>dd", '<cmd>lua R("custom.wiki").make_diary_entry()<CR>', { noremap = true })
keymap.set("n", "<leader>td", '<cmd>lua R("custom.wiki").make_todo()<CR>', { noremap = true })

-- Trouble
keymap.set("n", "<leader>x", "<cmd>TroubleToggle<CR>")                                         -- Show all problems in project (with help of LSP)
keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>")                                       -- Show use of object in project
