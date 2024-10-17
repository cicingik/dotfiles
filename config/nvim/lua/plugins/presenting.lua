return {
	"sotte/presenting.vim",
	{
		"iamcco/markdown-preview.nvim",
		build = function() vim.fn["mkdp#util#install"]() end,
		config = function()
			vim.g.mkdp_auto_close = true
			vim.g.mkdp_open_to_the_world = false
			vim.g.mkdp_open_ip = "127.0.0.1"
			vim.g.mkdp_port = "8888"
			vim.g.mkdp_browser = ""
			vim.g.mkdp_echo_preview_url = true
			vim.g.mkdp_page_title = "${name}"
		end,
	},

	{
		"lukas-reineke/headlines.nvim",
		opts = function()
			local opts = {}
			for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
				opts[ft] = {
					headline_highlights = {},
					-- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
					bullets = {},
				}
				for i = 1, 6 do
					local hl = "Headline" .. i
					vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
					table.insert(opts[ft].headline_highlights, hl)
				end
			end
			return opts
		end,
		ft = { "markdown", "norg", "rmd", "org" },
		config = function(_, opts)
			-- PERF: schedule to prevent headlines slowing down opening a file
			vim.schedule(function()
				require("headlines").setup(opts)
				require("headlines").refresh()
			end)
		end,
	},

	{
		"mzlogin/vim-markdown-toc",
	}
}
