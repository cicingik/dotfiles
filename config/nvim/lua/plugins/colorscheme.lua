return {
    "neanias/everforest-nvim",
    {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup()
    end,
    }
}
