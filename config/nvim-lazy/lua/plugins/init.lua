return {
  { "nvim-lua/plenary.nvim", dev = false },
  { "tjdevries/cyclist.vim" },
  { "tjdevries/express_line.nvim", dev = false },
  -- { "tjdevries/overlength.vim" },
  { "tjdevries/green_light.nvim" },
  { "tjdevries/complextras.nvim" },
  { "tjdevries/vim9jit" },
  { "tjdevries/monkey.nvim" },
  { "tjdevries/complextras.nvim" },
  "milisims/nvim-luaref",
  "tpope/vim-surround",
  "godlygeek/tabular", -- Quickly align text by pattern
  "tpope/vim-repeat", -- Repeat actions better
  "tpope/vim-abolish", -- Cool things with words!
  "tpope/vim-characterize", -- ?
  "tpope/vim-scriptease",
  "romainl/vim-qf",
  "mkitt/tabline.vim",
  "monaqa/dial.nvim",
  "TimUntersberger/neogit",
  "xiyaowong/nvim-transparent",
  "tjdevries/colorbuddy.nvim",
  "simrat39/rust-tools.nvim",
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup {
        setopt = true,
      }
    end,
  },

  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },

  "projekt0n/github-nvim-theme",
}
