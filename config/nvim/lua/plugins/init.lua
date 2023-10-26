return {
  { "nvim-lua/plenary.nvim", dev = false },
  { "tjdevries/express_line.nvim", dev = false }, -- status line
  "tjdevries/cyclist.vim", -- cycle + listchars
  "tjdevries/complextras.nvim", -- ins-completion in neovim
  "tjdevries/vim9jit",
  "milisims/nvim-luaref", -- vim :help reference for lua
  "tpope/vim-surround",
  "godlygeek/tabular", -- Quickly align text by pattern
  "tpope/vim-repeat", -- Repeat actions better
  "tpope/vim-abolish", -- Cool things with words!
  "tpope/vim-characterize",
  "tpope/vim-scriptease",
  "romainl/vim-qf",
  "mkitt/tabline.vim", -- tab in nvim
  "monaqa/dial.nvim",
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup {
        setopt = true,
      }
    end,
  }, -- configurable 'statuscolumn' and click handlers.
  "vimwiki/vimwiki",
  {
    "folke/trouble.nvim",
    lazy = true,
    dependencies = "kyazdani42/nvim-web-devicons",
  },
  "folke/which-key.nvim",
}
