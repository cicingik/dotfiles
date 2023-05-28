vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  actions = {
    open_file = { quit_on_open = true }
  },
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  filters = {
    custom = { '^.git$', '^node_modules$' }
  },
  git = {
    enable = false
  },
  log = {
    enable = true,
    types = {
      diagnostics = true
    }
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = ''
    }
  },
  view = {
    width = 30,
    side = "left",
    mappings = {
      list = {
        { key = "<leader>v", cb = tree_cb "vsplit" },
        { key = "<leader>h", cb = tree_cb "split" },
      },
    },
  },
})
