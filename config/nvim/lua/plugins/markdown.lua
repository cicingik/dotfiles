return {
  "sotte/presenting.vim",
  { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end },
}
