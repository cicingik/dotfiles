return {
	"rhysd/git-messenger.vim",

	"rhysd/committia.vim",    -- Sweet commit messages
	"sindrets/diffview.nvim", -- Sweet diff helper

	"Rawnly/gist.nvim",       -- Gist helper
	"f-person/git-blame.nvim", -- Git blamme
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = function()
			require("gitsigns").setup {
				signs = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				signs_staged = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				-- signs = {
				--   add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr" },
				--   change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr" },
				--   delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr" },
				--   topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr" },
				--   changedelete = { hl = "GitSignsDelete", text = "~", numhl = "GitSignsChangeNr" },
				-- },
				signcolumn = true,

				-- Highlights just the number part of the number column
				numhl = true,

				-- Highlights the _whole_ line.
				--    Instead, use gitsigns.toggle_linehl()
				linehl = false,

				-- Highlights just the part of the line that has changed
				--    Instead, use gitsigns.toggle_word_diff()
				word_diff = false,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				status_formatter = nil, -- Use default
				update_debounce = 200,
				max_file_length = 40000,
				preview_config = {
					-- Options passed to nvim_open_win
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			}
		end
	},
}
