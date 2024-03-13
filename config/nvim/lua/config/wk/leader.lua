return {
  mode = { "n", "v" },
  w = { "<cmd>w!<cr>", "Save" },
  q = { "<cmd>confirm q<cr>", "Quit" },
  c = { "<cmd>bd<cr>", "Close Buffer" },
  o = { "<cmd>Telescope buffers<cr>", "Open Buffer" },
  e = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
  m = { "<cmd>MarkdownPreview<cr>", "Open markdown in web browser" },
  j = { "<cmd>HopWord<cr>", "Go to any word in the current buffer" },
  l = { "<cmd>AerialToggle!<cr>", "Areal Toggle" },
  x = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
  X = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
  U = { "<cmd>UndotreeToggle<cr>", "Toggle UndoTree" },
  Z = { "<cmd>ZenMode<cr>", "Zen Mode" },

  mr = { "<cmd>CellularAutomaton make_it_rain<cr>", "Make it rain" },
  ["<C-q>"] = { "<cmd>Telescope Quickfix<cr>", "Quickfix" },


  s = {
    name = "Search",
    h = { "<cmd>Telescope help_tags<cr>", "Search Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Search Keymaps" },
    f = { "<cmd>Telescope find_files<cr>", "Search Files (CWD)" },
    s = { "<cmd>Telescope builtin<cr>", "Search Select Telescope" },
    w = { "<cmd>Telescope grep_string<cr>", "Select Current Word" },
    g = { "<cmd>Telescope live_grep<cr>", "Search by Grep" },
    d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
    r = { "<cmd>Telescope resume<cr>", "Search Resume" },
    o = { "<cmd>Telescope oldfiles<cr>", "Search Recent Files ('.' for repeat)" },
    t = { "<cmd>TodoTelescope<cr>", "Todo Lists" }
  },

  g = {
    name = "Git",
    g = { "<cmd>LazyGit<cr>", "LazyGit Toogle" },
    h = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    l = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
  },

  p = {
    name = "Python Virtualenv",
    v = { "<cmd>VenvSelect<cr>", "Venv Selector" },
    c = { "<cmd>VenvSelectCached<cr>", "Retrieve the venv from a cache" },
  },

  d = {
    name = "DAP",
    c = { "<cmd>Telescope dap commands<cr>", "Dap Commands" },
    b = { "<cmd>Telescope dap list_breakpoints<cr>", "Dap Breakpoints" },
    g = { "<cmd>Telescope dap configurations<cr>", "Dap Configurations" },
    v = { "<cmd>Telescope dap variables<cr>", "Dap Variables" },
    f = { "<cmd>Telescope dap frames<cr>", "Dap Frames" },
  },

  ['\\'] = {
    name = "Terminal",
    h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm direction=vertical size=100 <cr>", "Vertical" },
  },
}
