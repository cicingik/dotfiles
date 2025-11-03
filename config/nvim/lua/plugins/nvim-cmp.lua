-- set keybinds for both INSERT and VISUAL.
vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})

local ls_config = function()
  local ls = require("luasnip")

  local s = ls.snippet
  local fmt = require("luasnip.extras.fmt").fmt
  local t = ls.text_node
  local i = ls.insert_node
  local types = require("luasnip.util.types")
  local rep = require("luasnip.extras").rep
  local extras = require("luasnip.extras")


  ls.setup({
    keep_roots = true,
    link_roots = true,
    link_children = true,

    -- Update more often, :h events for more info.
    update_events = "TextChanged,TextChangedI",
    -- Snippets aren't automatically removed if their text is deleted.
    -- `delete_check_events` determines on which events (:h events) a check for
    -- deleted snippets is performed.
    -- This can be especially useful when `history` is enabled.
    delete_check_events = "TextChanged",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "choiceNode", "Comment" } },
        },
      },
    },
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = true,
    -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
    -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
    store_selection_keys = "<Tab>",
    -- luasnip uses this function to get the currently active filetype. This
    -- is the (rather uninteresting) default, but it's possible to use
    -- eg. treesitter for getting the current filetype by setting ft_func to
    -- require("luasnip.extras.filetype_functions").from_cursor (requires
    -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
    -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
    ft_func = function()
      return vim.split(vim.bo.filetype, ".", { plain = true })
    end,
  })

  -- set type to "autosnippets" for adding autotriggered snippets.
  ls.add_snippets("all", {
    s("autotrigger", {
      t("autosnippet"),
    }),
  }, {
    type = "autosnippets",
    key = "all_auto",
  })

  ls.add_snippets("markdown", {

    s("dateISO", { extras.partial(os.date, "%Y-%m-%d") }),

    s("date", { extras.partial(os.date, "%B %-d, %Y") }),

    s("dept",
      fmt([[
      - Issues \
        {issues}
      - Impacted \
        {impacted}
      - Improvement \
        {improv}
      - Expected Result \
        {expected}
    ]], {
        issues = ls.i(1, ""),
        impacted = ls.i(2, ""),
        improv = ls.i(3, ""),
        expected = ls.i(4, ""),
      })),

    s("tabdept",
      fmt([[
      | Issues   | Impact     | Solution | Expected Improvement |
      |----------|------------|----------|----------------------|
      | {issues} | {impacted} | {improv} | {expected}           |
    ]], {
        issues = ls.i(1, ""),
        impacted = ls.i(2, ""),
        improv = ls.i(3, ""),
        expected = ls.i(4, ""),
      })),

    s("erd",
      fmt(
        [[
      ```mermaid
      erDiagram
      {start}
      ```
        ]], {
          start = ls.i(1, ""),
        }
      )
    )

  })

  ls.add_snippets("python", {
    s("pyhead",
      fmt(
        [[
      #!/usr/bin/env python3
      # -*- coding: utf-8 -*-
      """

      Author: cicingik
      Copyright (C) 2025
      """
        ]], {}
      )
    ),

    s("long", fmt(" # noqa: E501 pylint: disable=line-too-long", {}))

  })
end


return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  branch = 'main',
  dependencies = {
    { 'onsails/lspkind.nvim' },
    { 'saadparwaiz1/cmp_luasnip' },
    {
      'L3MON4D3/LuaSnip',
      dependencies = { "rafamadriz/friendly-snippets" },
      tag = "v2.2.0",
      config = ls_config,
    },
  },
  config = function()
    require('lsp-zero.cmp').extend()
    require("luasnip.loaders.from_vscode").lazy_load()

    local cmp         = require('cmp')
    local luasnip     = require('luasnip')
    local cmp_mapping = cmp.mapping
    local cmp_action  = require('lsp-zero.cmp').action()
    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
          })[entry.source.name]
          vim_item.dup = ({
            buffer = 1,
            nvim_lsp = 0,
            luasnip = 0,
          })[entry.source.name] or 0
          return vim_item
        end,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        }),
      },
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
      }, {
        { name = 'buffer' },
      }),
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        ["<C-Space>"] = cmp_mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm(),
      }),
    })
  end
}
