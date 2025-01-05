return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    local nills = require("null-ls")

    nills.setup({
      sources = {
        -- nills.builtins.formatting.stylua,
        nills.builtins.completion.spell,

        -- nills.diagnostics.golangci_lint,
        nills.builtins.formatting.gofmt,
        -- nills.builtins.diagnostics.staticcheck.with({
        --   method = nills.methods.DIAGNOSTICS_ON_SAVE,
        -- }),
        nills.builtins.formatting.gofumpt,
        -- nills.builtins.formatting.goimports.with({
        --   method = nills.methods.DIAGNOSTICS_ON_SAVE,
        -- }),
        nills.builtins.formatting.goimports_reviser,
        -- nills.builtins.formatting.golines,
        nills.builtins.code_actions.impl,
        nills.builtins.diagnostics.revive,
        nills.builtins.code_actions.gomodifytags,

        -- nills.builtins.diagnostics.write_good.with({
        --   diagnostics_postprocess = function(diagnostic)
        --     diagnostic.severity = diagnostic.message:find("really") and vim.diagnostic.severity["ERROR"]
        --         or vim.diagnostic.severity["WARN"]
        --   end,
        -- }),
        nills.builtins.code_actions.refactoring,

        nills.builtins.diagnostics.pylint,
        nills.builtins.formatting.isort,
        nills.builtins.formatting.black,
        -- nills.builtins.diagnostics.pylint.with({
        --   diagnostics_postprocess = function(diagnostic)
        --     diagnostic.code = diagnostic.message_id
        --   end,
        -- }),
      },
    })
  end
}
