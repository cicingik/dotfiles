local options = {
  incsearch = true,                        -- make search act like search in modern browsers
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 2,                        -- so that `` is visible in markdown files
  encoding = 'utf-8',
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 100,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  breakindent = true,                      -- wrap lines with indent
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                             -- display lines as one long line
  scrolloff = 3,                           -- Makes sure there are always eight lines of context
  sidescrolloff = 3,                       -- Makes sure there are always eight lines of context
  laststatus = 0,                          -- Always display the status line
  showcmd = false,                         -- Don't show the command in the last line
  ruler = false,                           -- Don't show the ruler
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  title = true,                            -- set the title of window to the value of the titlestring
  confirm = true,                          -- confirm to save changes before exiting modified buffer
  fillchars = { eob = " " },               -- change the character at the end of buffer
  autoread = true,                         -- Automatically re-read files if unmodified inside Vim.
  -- cursorlineopt = "number",             -- set the cursorline
  softtabstop = 2,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  autoindent = true
}

vim.scriptencoding = 'utf-8'
vim.bo.autoread = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.python3_host_prog = '/home/dany_ulysses/.pyenv/shims/python3'

vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars =
"['╭','─', '╮', '│', '╯','─', '╰', '│']" -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = '' -- custom config file path

vim.g.indent_blankline_show_current_context = true

vim.g.go_fmt_command = "gofmt"
vim.g.go_addtags_transform = "camelcase"

-- Lsp Related
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.vsnip_filetypes = {}
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- if a file is a .env or .envrc file, set the filetype to sh
vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".envrc"] = "sh",
    ["*.env"] = "sh",
    ["*.envrc"] = "sh"
  }
})

vim.cmd([[ set nofoldenable]])

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 300,
    })
  end
})

vim.diagnostic.config({
  title            = false,
  underline        = true,
  virtual_text     = true,
  signs            = true,
  update_in_insert = false,
  severity_sort    = true,
  float            = {
    source = "if_many",
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
})

vim.fn.sign_define({
  {
    name = 'DiagnosticSignError',
    text = '',
    texthl = 'DiagnosticSignError',
    linehl = 'ErrorLine',
  },
  {
    name = 'DiagnosticSignWarn',
    text = '',
    texthl = 'DiagnosticSignWarn',
    linehl = 'WarningLine',
  },
  {
    name = 'DiagnosticSignInfo',
    text = '',
    texthl = 'DiagnosticSignInfo',
    linehl = 'InfoLine',
  },
  {
    name = 'DiagnosticSignHint',
    text = '',
    texthl = 'DiagnosticSignHint',
    linehl = 'HintLine',
  },
})
