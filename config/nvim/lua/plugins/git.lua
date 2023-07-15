return {
  "TimUntersberger/neogit", -- git
  "lewis6991/gitsigns.nvim",

  "rhysd/git-messenger.vim",

  "rhysd/committia.vim", -- Sweet commit messages
  "sindrets/diffview.nvim", -- Sweet diff helper

  "Rawnly/gist.nvim", -- Gist helper
  "f-person/git-blame.nvim", -- Git blamme
  {
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
  },
}
