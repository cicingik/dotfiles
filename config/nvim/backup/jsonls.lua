vim.lsp.config.jsonls = {
  settings = {
    json = {
      schema = require('schemastore').json.schemas(),
       validate = { enable = true },
    }
  }
}
