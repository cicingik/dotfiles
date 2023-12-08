local M = {}
local keymap = vim.keymap

M.imap = function(tbl)
  keymap.set("i", tbl[1], tbl[2], tbl[3])
end

M.nmap = function(tbl)
  keymap.set("n", tbl[1], tbl[2], tbl[3])
end

return M
