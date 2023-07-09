if not pcall(require, "zen-mode") then
  return
end

require("zen-mode").setup {
  window = {
    backdrop = 1,
    height = 0.9,
    -- width = 140,
    options = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
      list = false,
      cursorline = false,
    },
  },
}

require("twilight").setup {
  context = -1,
  treesitter = true,
}

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

require("notify").setup({
  background_colour = "#df8882",
})
