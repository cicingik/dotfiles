require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'gopls',
    'rust_analyzer'
  },
  automatic_installation = true,
})

-- require 'lspconfig'.pyright.setup {}
