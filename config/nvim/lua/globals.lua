local opt = vim.opt

-- Show the line number relative to the line with the cursor in front of each line
opt.number = true
opt.relativenumber = true

-- Text Rendering Options
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.scrolloff = 5
opt.sidescrolloff = 5

-- Search Options
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- User Interface Options
opt.mouse = 'a'
opt.cursorline = true

-- Indention Options
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Disable swap files
opt.swapfile = false
-- Automatically re-read files if unmodified inside Vim.
opt.autoread = true

-- Miscellaneous Options
vim.bo.autoread = true
opt.signcolumn = 'yes'
opt.list = true
opt.clipboard:append('unnamedplus')
opt.updatetime = 300
opt.timeoutlen = 500

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 300
    })
  end
})

local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = require
if ok then
  reloader = plenary_reload.reload_module
end

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  local ok, plenary_reload = pcall(require, "plenary.reload")
  if ok then
    reloader = plenary_reload.reload_module
  end

  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
