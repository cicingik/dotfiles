return {
  "simrat39/rust-tools.nvim", -- rust tools devvelopment
  {
    "Saecki/crates.nvim",
    config = function()
      require("crates").setup()
    end,
  },
}
