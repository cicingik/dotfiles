return {
  "jhofscheier/nvim-texis",
  dependencies = { "neovim/nvim-lspconfig", },
  opts = {
    cache = {
      ---path and filename where nvim-rpc-servernames are stored
      filename = vim.api.nvim_call_function(
        'stdpath',
        { 'cache' }
      ) .. '/nvim_servernames.log',
    },
    inverse_search = {
      ---command used for inverse search to open file (equivalent to `:e`)
      edit_cmd = vim.cmd.edit,
      ---nil or function that is executed before inverse search is executed
      ---@type nil|function()
      pre_cmd = nil,
      ---nil or function that is exectued after inverse seach is executed
      ---@type nil|function()
      post_cmd = nil,
    },
  },
}
