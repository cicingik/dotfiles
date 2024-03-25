return {
  mode = { "n", "v" },

  w = { "<cmd>w!<cr>", "Save" },
  q = { "<cmd>confirm q<cr>", "Quit" },
  c = { "<cmd>bd<cr>", "Close Buffer" },
  p = { "<cmd>Telescope buffers<cr>", "Buffer Open" },
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
    x = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
    r = { "<cmd>Telescope resume<cr>", "Search Resume" },
    o = { "<cmd>Telescope oldfiles<cr>", "Search Recent Files ('.' for repeat)" },
    t = { "<cmd>TodoTelescope<cr>", "Todo Lists" },
  },

  g = {
    name = "Git",
    g = { "<cmd>LazyGit<cr>", "LazyGit Toogle" },
    h = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    l = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
  },

  v = {
    name = "Python Virtualenv",
    v = { "<cmd>VenvSelect<cr>", "Venv Selector" },
    c = { "<cmd>VenvSelectCached<cr>", "Retrieve the venv from a cache" },
  },

  d = {
    name = "Debug",
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    c = { "<cmd>Telescope dap commands<cr>", "Dap Commands" },
    B = { "<cmd>Telescope dap list_breakpoints<cr>", "Dap Breakpoints" },
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    g = { "<cmd>Telescope dap configurations<cr>", "Dap Configurations" },
    S = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
  },

  o = {
    name = "Obsidian",
    w = { "<cmd>ObsidianWorkspace<cr>", "Workspaces" },
    n = { "<cmd>ObsidianNew<cr>", "New Page" },
    d = { "<cmd>ObsidianToday<cr>", "Daily Note" },
    s = { "<cmd>ObsidianSearch<cr>", "Search" },
    t = { "<cmd>ObsidianTemplate<cr>", "Template" },
    x = { "<cmd>ObsidianTags<cr>", "Search by Tag" },
  },

  ['\\'] = {
    name = "Terminal",
    h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm direction=vertical size=100 <cr>", "Vertical" },
  },
}
