return {
  {
    "norcalli/nvim-colorizer.lua",     -- highlighter colour code
    config = function()
      require("colorizer").setup(
        {
          '*',
          user_default_options = { mode = "background" }
        }
      )
    end
  },
  {
    "norcalli/nvim-terminal.lua",
    config = function()
      require("terminal").setup({})
    end,
  },
}
