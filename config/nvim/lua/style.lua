require 'todo-comments'.setup()

require("transparent").setup({
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
  },
  extra_groups = { -- table/string: additional groups that should be cleared
    "Comment"
  },
  exclude_groups = {}, -- table: groups you don't want to clear
})

require 'noice'.setup({
  messages = {
    enable = true
  }
})
require 'notify'.setup({
  background_colour = "#000000",
  render = 'minimal'
})
