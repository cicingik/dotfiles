return {
  {
    "neovim/nvim-lspconfig",
     config = function()
       require "cicingik.lsp"
     end,
     dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim"
            },
            opts = { lsp = { auto_attach = true } }
        }
    },
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup {
        auto_update = true,
        debounce_hours = 24,
        ensure_installed = {},
      }
    end,
  },

  "simrat39/inlay-hints.nvim",
  {"j-hui/fidget.nvim", tag = 'legacy'},
  "folke/neodev.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  "scalameta/nvim-metals",
  "b0o/schemastore.nvim",
  {
    "nvimdev/lspsaga.nvim",
    dev = true,
  },
  -- "fatih/vim-go",
}
