require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'tsserver',
    'graphql',
    'rust_analyzer'
  },
  automatic_installation = true,
})

require 'lspconfig'.pyright.setup {}
