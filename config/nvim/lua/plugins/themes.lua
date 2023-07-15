return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup()
      end,
  },
  "tjdevries/colorbuddy.nvim", -- making cool neovim color schemes
  "norcalli/nvim-colorizer.lua",
   {
     "norcalli/nvim-terminal.lua",
     config = function()
       require("terminal").setup()
     end,
   },
  "xiyaowong/nvim-transparent", -- Remove all background colors to make nvim transparent
  "RRethy/vim-illuminate", -- automatically highlighting other uses of the word under the cursor
}
