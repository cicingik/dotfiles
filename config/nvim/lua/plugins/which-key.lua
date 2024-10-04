local options = {
	stay_on_this_version = false,
	plugins = {
		marks = true,   -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true,   -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true,   -- default bindings on <c-w>
			nav = true,       -- misc bindings to work with windows
			z = true,         -- bindings for folds, spelling and others prefixed with z
			g = true,         -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	replace = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	win = {
		border = "none",        -- none, single, double, shadow
		title_pos = "bottom",   -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
		padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,           -- value between 0-100 0 for fully opaque and 100 for fully transparent
		zindex = 1000,          -- positive value to position WhichKey above other floating windows.
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3,                  -- spacing between columns
		align = "left",               -- align columns left, center or right
	},
	show_help = true,               -- show a help message in the command line for using WhichKey
	show_keys = true,               -- show the currently pressed key and its label as a message in the command line
	-- automatically setup triggers
	-- triggers = {
	-- 	{ "<auto>", mode = "nixsotc" },
	-- 	{ "a",      mode = { "n", "v" } },
	-- },
	-- disable the WhichKey popup for certain buf typs and file types.
	-- Disabled by default for Telescope
	disable = {
		buftypes = {},
		filetypes = {},
	},
}

return {
	"folke/which-key.nvim",
	dependencies = { 'echasnovski/mini.icons', version = false },
	event = "VimEnter",
	lazy = true,
	opts = options,
	config = function(_, opts)
		local which_key = require("which-key")
		which_key.setup(opts)
		which_key.add(require('config.wk.mapping'))
	end
}
