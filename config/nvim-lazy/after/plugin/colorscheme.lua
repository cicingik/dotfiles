if not pcall(require, "colorbuddy") then
  return
end


vim.opt.termguicolors = true
require("colorbuddy").colorscheme "everforest"
require("colorizer").setup()

vim.g.everforest_diagnostic_line_highlight = 1

