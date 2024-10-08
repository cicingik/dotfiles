return {
	{ "h",                "<cmd>nohlsearch<cr>",                                                     desc = "No Highlight",                         mode = { "n", "v" } },
	{ "q",                "<cmd>confirm q<cr>",                                                      desc = "Quit",                                 mode = { "n", "v" } },

	{ "<leader>w",        "<cmd>w!<cr>",                                                             desc = "Save",                                 mode = { "n", "v" } },
	{ "<leader>q",        "<cmd>confirm q<cr>",                                                      desc = "Quit",                                 mode = { "n", "v" } },
	{ "<leader>c",        "<cmd>bd<cr>",                                                             desc = "Close Buffer",                         mode = { "n", "v" } },
	{ "<leader>m",        "<cmd>MarkdownPreview<cr>",                                                desc = "Open markdown in browser",             mode = { "n", "v" } },
	{ "<leader>j",        "<cmd>HopWord<cr>",                                                        desc = "Jump to front of any word on buffer",  mode = { "n", "v" } },
	{ "<leader>l",        "<cmd>AerialToggle<cr>",                                                   desc = "Preview Code Outline",                 mode = { "n", "v" } },
	{ "<leader>x",        "<cmd>Trouble diagnostics<cr>",                                            desc = "Document Diagnostics (Trouble)",       mode = { "n", "v" } },
	{ "<leader>X",        "<cmd>Trouble workspace_diagnostics<cr>",                                  desc = "Workspace Diagnostics (Trouble)",      mode = { "n", "v" } },
	{ "<leader>U",        "<cmd>UndotreeToggle<cr>",                                                 desc = "Toggle Undotree",                      mode = { "n", "v" } },
	{ "<leader>Z",        "<cmd>ZenMode<cr>",                                                        desc = "Zen Mode",                             mode = { "n", "v" } },
	{ "<leader><C-q>",    "<cmd>Telescope quickfix<cr>",                                             desc = "Quickfix",                             mode = { "n", "v" } },
	{ "<leader><leader>", "<cmd>Telescope buffers<cr>",                                              desc = "Buffer Open",                          mode = { "n", "v" } },

	{ "<leader>t",        "<cmd>Telescope<cr>",                                                      desc = "Telescope", mode = { "n", "v" } },
	{ "<leader>st",       "<cmd>TodoTelescope<cr>",                                                  desc = "Search Code Notes",                    mode = { "n", "v" } },
	{ "<leader>sh",       "<cmd>Telescope help_tags<cr>",                                            desc = "Search Help",                          mode = { "n", "v" } },
	{ "<leader>sk",       "<cmd>Telescope keymaps<cr>",                                              desc = "Search Keymaps",                       mode = { "n", "v" } },
	{ "<leader>sf",       "<cmd>Telescope find_files<cr>",                                           desc = "Search Files (CWD)",                   mode = { "n", "v" } },
	{ "<leader>ss",       "<cmd>Telescope builtin<cr>",                                              desc = "Search Select Telescope",              mode = { "n", "v" } },
	{ "<leader>sw",       "<cmd>Telescope grep_string<cr>",                                          desc = "Search Current Word",                  mode = { "n", "v" } },
	{ "<leader>sg",       "<cmd>Telescope live_grep<cr>",                                            desc = "Search by Grep",                       mode = { "n", "v" } },
	{ "<leader>sx",       "<cmd>Telescope diagnostics<cr>",                                          desc = "Search Diagnostics",                   mode = { "n", "v" } },
	{ "<leader>sr",       "<cmd>Telescope resume<cr>",                                               desc = "Resume Search",                        mode = { "n", "v" } },
	{ "<leader>so",       "<cmd>Telescope oldfiles<cr>",                                             desc = "Search Recent Files ('.' for repeat)", mode = { "n", "v" } },

	{ "<leader>g",       "<cmd>LazyGit<cr>",                                                        desc = "LazyGit", mode = { "n", "v" } },
	{ "<leader>gp",       "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",                          desc = "Preview Hunk",                         mode = { "n", "v" } },
	{ "<leader>gh",       "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk",                            mode = { "n", "v" } },
	{ "<leader>gl",       "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = "Next Hunk",                            mode = { "n", "v" } },

	{ "<leader>p",       "<cmd>VenvSelect<cr>",                                                     desc = "Python Virtualenv", mode = { "n", "v" } },
	{ "<leader>pc",       "<cmd>VenvSelectCached<cr>",                                               desc = "Retrieve the venv from a cache",       mode = { "n", "v" } },

	{ "<leader>d",       "<cmd>lua require'dapui'.toggle()<cr>",                                    desc = "DAP UI", mode = { "n", "v" } },
	{ "<leader>dc",       "<cmd>Telescope dap commands<cr>",                                         desc = "Dap Commands",                         mode = { "n", "v" } },
	{ "<leader>dB",       "<cmd>Telescope dap list_breakpoints<cr>",                                 desc = "Dap Breakpoints",                      mode = { "n", "v" } },
	{ "<leader>db",       "<cmd>lua require'dap'.toggle_breakpoint()<cr>",                           desc = "Breakpoint",                           mode = { "n", "v" } },
	{ "<leader>dg",       "<cmd>Telescope dap configurations<cr>",                                   desc = "Dap Configurations",                   mode = { "n", "v" } },
	{ "<leader>ds",       "<cmd>lua require'dap'.continue()<cr>",                                    desc = "Continue",                             mode = { "n", "v" } },
	{ "<leader>di",       "<cmd>lua require'dap'.step_into()<cr>",                                   desc = "Into",                                 mode = { "n", "v" } },
	{ "<leader>do",       "<cmd>lua require'dap'.step_over()<cr>",                                   desc = "Over",                                 mode = { "n", "v" } },
	{ "<leader>dO",       "<cmd>lua require'dap'.step_out()<cr>",                                    desc = "Out",                                  mode = { "n", "v" } },
	{ "<leader>dr",       "<cmd>lua require'dap'.repl.toggle()<cr>",                                 desc = "Repl",                                 mode = { "n", "v" } },
	{ "<leader>dl",       "<cmd>lua require'dap'.run_last()<cr>",                                    desc = "Last",                                 mode = { "n", "v" } },
	{ "<leader>dx",       "<cmd>lua require'dap'.terminate()<cr>",                                   desc = "Exit",                                 mode = { "n", "v" } },

	{ "<leader>o",       "<cmd>ObsidianWorkspace<cr>",                                              desc = "Obsidian Workspace" , mode = { "n", "v" }},
	{ "<leader>on",       "<cmd>ObsidianNew<cr>",                                                    desc = "New Page",                             mode = { "n", "v" } },
	{ "<leader>od",       "<cmd>ObsidianToday<cr>",                                                  desc = "Daily Note",                           mode = { "n", "v" } },
	{ "<leader>of",       "<cmd>ObsidianSearch<cr>",                                                 desc = "Search",                               mode = { "n", "v" } },
	{ "<leader>ot",       "<cmd>ObsidianTemplate<cr>",                                               desc = "Template",                             mode = { "n", "v" } },
	{ "<leader>oa",       "<cmd>ObsidianTags<cr>",                                                   desc = "Search by Tag",                        mode = { "n", "v" } },
	{ "<leader>of",       "<cmd>ObsidianQuickSwitch<cr>",                                            desc = "Browse Files",                         mode = { "n", "v" } },

	{ "<leader>\\",       "<cmd>ToggleTerm<cr>",                                                     desc = "Terminal", mode = { "n", "v" } },
	{ "<leader>\\h",      "<cmd>ToggleTerm direction=horizontal<cr>",                                desc = "Horizontal Terminal",                  mode = { "n", "v" } },
	{ "<leader>\\v",      "<cmd>ToggleTerm direction=vertical size 100<cr>",                         desc = "Vertical Terminal",                    mode = { "n", "v" } },

	{ "<leader>a",       ":<c-u>lua require('ollama').prompt()<cr>",                                desc = "Assistant", mode = { "n", "v" } },
	{ "<leader>aq",       ":<c-u>lua require('ollama').prompt('Raw')<cr>",                           desc = "Asking",                               mode = { "n", "v" } },
	{ "<leader>ag",       ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",                 desc = "Generate Code",                        mode = { "n", "v" } }
}
