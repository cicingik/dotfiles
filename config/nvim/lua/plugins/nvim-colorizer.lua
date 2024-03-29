return {
  {
    "norcalli/nvim-colorizer.lua", -- highlighter colour code
    config = function()
      require("colorizer").setup(
        {
          'yaml',
          'css',
          'javascript',
          html = {
            mode = 'foreground',
          }
        }
      )
    end
  },
  {
    "norcalli/nvim-terminal.lua",
    config = function()
      require("terminal").setup()
    end,
  },
}
