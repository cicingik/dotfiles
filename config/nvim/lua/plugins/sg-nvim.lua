local ok, lsp = pcall(require, "lsp-zero")
if not ok then
  return
end

return {
  -- {
  --   "sourcegraph/sg.nvim",
  --   event = { 'InsertEnter', 'VeryLazy' },
  --   lazy = true,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "VonHeikemen/lsp-zero.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --
  --   -- If you have a recent version of lazy.nvim, you don't need to add this!
  --   opts = {
  --     on_attach = lsp.on_attach,
  --   },
  --   build = "nvim -l build/init.lua",
  --   keys = {
  --     {
  --       "<leader>css",
  --       function()
  --         require("sg.extensions.telescope").fuzzy_search_results()
  --       end,
  --       desc = "Sourcegraph search",
  --     },
  --     {
  --       "<leader>csc",
  --       "<cmd>CodyToggle<cr>",
  --       desc = "Cody toggle",
  --       mode = { "n" },
  --     },
  --   },
  -- },
}
