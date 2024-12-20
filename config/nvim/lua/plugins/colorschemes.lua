return {
    {
        "neanias/everforest-nvim",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        priority = 1000,
        config = function()
            require("everforest").setup(
                {
                    transparent = true,
                    ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
                    ---Default is "medium".
                    background = "medium",
                    ---How much of the background should be transparent. 2 will have more UI
                    ---components be transparent (e.g. status line background)
                    transparent_background_level = 1,
                    ---Whether italics should be used for keywords and more.
                    italics = false,
                    ---Disable italic fonts for comments. Comments are in italics by default, set
                    ---this to `true` to make them _not_ italic!
                    disable_italic_comments = false,
                    ---By default, the colour of the sign column background is the same as the as normal text
                    ---background, but you can use a grey background by setting this to `"grey"`.
                    sign_column_background = "none",
                    ---The contrast of line numbers, indent lines, etc. Options are `"high"` or
                    ---`"low"` (default).
                    ui_contrast = "high",
                    ---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
                    dim_inactive_windows = false,
                    ---Some plugins support highlighting error/warning/info/hint texts, by
                    ---default these texts are only underlined, but you can use this option to
                    ---also highlight the background of them.
                    diagnostic_text_highlight = false,
                    ---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
                    diagnostic_virtual_text = "coloured",
                    ---Some plugins support highlighting error/warning/info/hint lines, but this
                    ---feature is disabled by default in this colour scheme.
                    diagnostic_line_highlight = false,
                    ---By default, this color scheme won't colour the foreground of |spell|, instead
                    ---colored under curls will be used. If you also want to colour the foreground,
                    ---set this option to `true`.
                    spell_foreground = false,
                    ---You can override specific highlights to use other groups or a hex colour.
                    ---This function will be called with the highlights and colour palette tables.
                    -- ---@param highlight_groups Highlights
                    -- ---@param palette Palette
                    -- on_highlights = function(highlight_groups, palette) end,
                }
            )
            -- vim.cmd.colorscheme 'everforest'
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        config = function()
            require("kanagawa").setup({
                compile = false,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,   -- do not set background color
                dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                -- colors = {             -- add/modify theme and palette colors
                --     palette = {},
                --     theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                -- },
                -- theme = "wave",      -- Load "wave" theme when 'background' option is not set
                -- background = {       -- map the value of 'background' option to a theme
                --     dark = "dragon", -- try "dragon" !
                --     light = "wave"
                -- },
                --   overrides = function(colors)
                --     local theme = colors.theme
                --     return {
                --       Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                --       PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                --       PmenuSbar = { bg = theme.ui.bg_m1 },
                --       PmenuThumb = { bg = theme.ui.bg_p2 },
                --       TelescopeTitle = { fg = theme.ui.special, bold = true },
                --       TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                --       TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                --       TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                --       TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                --       TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                --       TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                --     }
                --   end,
                --   colors = {
                --     theme = {
                --       all = {
                --         ui = {
                --           bg_gutter = "none"
                --         }
                --       }
                --     }
                --   }
            })
            vim.cmd.colorscheme 'kanagawa-wave'
        end
    },
    "xiyaowong/nvim-transparent", -- Remove all background colors to make nvim transparent
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        opts = { delay = 200 },
        lazy = true,
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
        },
    },
}
