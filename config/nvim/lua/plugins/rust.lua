return {
  "simrat39/rust-tools.nvim", -- rust tools devvelopment
  {
    "Saecki/crates.nvim", -- managing crates.io dependencies
    config = function()
      require("crates").setup()
    end,
  },
}
