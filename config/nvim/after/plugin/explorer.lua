-- Turns off netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

local navbuddy = require("nvim-navbuddy")

require("lspconfig").clangd.setup {
  on_attach = function(client, bufnr)
    navbuddy.attach(client, bufnr)
  end
}

---- Navbuddy --------------------------------

local actions = require("nvim-navbuddy.actions")

navbuddy.setup {
  window = {
    border = "single", -- "rounded", "double", "solid", "none"
    -- or an array with eight chars building up the border in a clockwise fashion
    -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
    size = "60%",     -- Or table format example: { height = "40%", width = "100%"}
    position = "50%", -- Or table format example: { row = "100%", col = "0%"}
    scrolloff = nil,  -- scrolloff value within navbuddy window
    sections = {
      left = {
        size = "20%",
        border = nil, -- You can set border style for each section individually as well.
      },
      mid = {
        size = "40%",
        border = nil,
      },
      right = {
        -- No size option for right most section. It fills to
        -- remaining area.
        border = nil,
        preview = "leaf", -- Right section can show previews too.
        -- Options: "leaf", "always" or "never"
      }
    },
  },
  node_markers = {
    enabled = true,
    icons = {
      leaf = "  ",
      leaf_selected = " → ",
      branch = " ",
    },
  },
  icons = {
    File          = "󰈙 ",
    Module        = " ",
    Namespace     = "󰌗 ",
    Package       = " ",
    Class         = "󰌗 ",
    Method        = "󰆧 ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = "󰕘",
    Interface     = "󰕘",
    Function      = "󰊕 ",
    Variable      = "󰆧 ",
    Constant      = "󰏿 ",
    String        = " ",
    Number        = "󰎠 ",
    Boolean       = "◩ ",
    Array         = "󰅪 ",
    Object        = "󰅩 ",
    Key           = "󰌋 ",
    Null          = "󰟢 ",
    EnumMember    = " ",
    Struct        = "󰌗 ",
    Event         = " ",
    Operator      = "󰆕 ",
    TypeParameter = "󰊄 ",
  },
  use_default_mappings = true, -- If set to false, only mappings set
  -- by user are set. Else default
  -- mappings are used for keys
  -- that are not set by user
  mappings = {
    ["<esc>"] = actions.close(), -- Close and cursor to original location
    ["q"] = actions.close(),

    ["j"] = actions.next_sibling(),     -- down
    ["k"] = actions.previous_sibling(), -- up

    ["h"] = actions.parent(),           -- Move to left panel
    ["l"] = actions.children(),         -- Move to right panel
    ["0"] = actions.root(),             -- Move to first panel

    ["v"] = actions.visual_name(),      -- Visual selection of name
    ["V"] = actions.visual_scope(),     -- Visual selection of scope

    ["y"] = actions.yank_name(),        -- Yank the name to system clipboard "+
    ["Y"] = actions.yank_scope(),       -- Yank the scope to system clipboard "+

    ["i"] = actions.insert_name(),      -- Insert at start of name
    ["I"] = actions.insert_scope(),     -- Insert at start of scope

    ["a"] = actions.append_name(),      -- Insert at end of name
    ["A"] = actions.append_scope(),     -- Insert at end of scope

    ["r"] = actions.rename(),           -- Rename currently focused symbol

    ["d"] = actions.delete(),           -- Delete scope

    ["f"] = actions.fold_create(),      -- Create fold of current scope
    ["F"] = actions.fold_delete(),      -- Delete fold of current scope

    ["c"] = actions.comment(),          -- Comment out current scope

    ["<enter>"] = actions.select(),     -- Goto selected symbol
    ["o"] = actions.select(),

    ["J"] = actions.move_down(), -- Move focused node down
    ["K"] = actions.move_up(),   -- Move focused node up

    ["t"] = actions.telescope({  -- Fuzzy finder at current level.
      layout_config = {          -- All options that can be
        height = 0.60,           -- passed to telescope.nvim's
        width = 0.60,            -- default can be passed here.
        prompt_position = "top",
        preview_width = 0.50
      },
      layout_strategy = "horizontal"
    }),

    ["g?"] = actions.help(), -- Open mappings help window
  },
  lsp = {
    auto_attach = false, -- If set to true, you don't need to manually use attach function
    preference = nil,    -- list of lsp server names in order of preference
  },
  source_buffer = {
    follow_node = true, -- Keep the current node in focus on the source buffer
    highlight = true,   -- Highlight the currently focused node
    reorient = "smart", -- "smart", "top", "mid" or "none"
    scrolloff = nil     -- scrolloff value when navbuddy is open
  }
}

---- Lir --------------------------------

local has_lir, lir = pcall(require, "lir")
if not has_lir then
  return
end

local has_devicons, devicons = pcall(require, "nvim-web-devicons")
if has_devicons then
  devicons.setup {
    override = {
      lir_folder_icon = {
        icon = "",
        color = "#7ebae4",
        name = "LirFolderNode",
      },
    },
  }
end

local actions = require "lir.actions"
local has_mmv, mmv_actions = pcall(require, "lir.mmv.actions")

lir.setup {
  show_hidden_files = true,
  devicons = {
    enable = true,
  },

  float = { winblend = 15 },

  mappings = {
    ["<CR>"] = actions.edit,
    ["-"] = actions.up,

    ["K"] = actions.mkdir,
    ["N"] = actions.newfile,
    ["R"] = actions.rename,
    ["Y"] = actions.yank_path,
    ["D"] = actions.delete,
    ["."] = actions.toggle_show_hidden,

    -- mmv
    ["M"] = (has_mmv and mmv_actions.mmv) or nil,
  },
}

require("lir.git_status").setup {
  show_ignored = false,
}

vim.api.nvim_set_keymap("n", "-", ":edit %:h<CR>", { noremap = true })

-- Can do this if we want to get particular settings
-- vim.cmd [[
--   augroup LirSettings
--     au!
--     autocmd Filetype lir :lua LirSettings()
--   augroup END
-- ]]

-- Recommended actions, can play with these some more later.
-- ['l']     = actions.edit,
-- ['<C-s>'] = actions.split,
-- ['<C-v>'] = actions.vsplit,
-- ['<C-t>'] = actions.tabedit,

-- ['h']     = actions.up,
-- ['q']     = actions.quit,

-- ['N']     = actions.newfile,
-- ['R']     = actions.rename,
-- ['@']     = actions.cd,
-- ['Y']     = actions.yank_path,

-- ['J'] = function()
--   mark_actions.toggle_mark()
--   vim.cmd('normal! j')
-- end,
-- ['C'] = clipboard_actions.copy,
-- ['X'] = clipboard_actions.cut,
-- ['P'] = clipboard_actions.paste,

-- highlight link LirGitStatusBracket Comment
-- highlight link LirGitStatusIndex Special
-- highlight link LirGitStatusWorktree WarningMsg
-- highlight link LirGitStatusUnmerged ErrorMsg
-- highlight link LirGitStatusUntracked Comment
-- highlight link LirGitStatusIgnored Comment
