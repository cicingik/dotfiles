vim.api.nvim_set_keymap("n", "<leader>wd", '<cmd>lua R("wiki").make_diary_entry()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>wt", '<cmd>lua R("wiki").make_todo()<CR>', { noremap = true })
