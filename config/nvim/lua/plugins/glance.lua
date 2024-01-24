return {
  "dnlhc/glance.nvim",
  config = function()
    require("glance").setup({
      theme = {
        enable = true,
        mode = 'auto'
      },
      border = {
        enable = true,
        top_char = "─",
        bottom_char = "─",
      }
    })
  end,
  keys = {
    { "lD", "<CMD>Glance definitions<CR>",      desc = "Glance definitions" },
    { "lR", "<CMD>Glance references<CR>",       desc = "Glance references" },
    { "lY", "<CMD>Glance type_definitions<CR>", desc = "Glance type_definitions" },
    { "lM", "<CMD>Glance implementations<CR>",  desc = "Glance implementations" }
  }
}
