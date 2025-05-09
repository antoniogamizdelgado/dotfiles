return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- You can configure servers via lspconfig here if using other plugin integrations
      ruff_lsp = false, -- Disabling Ruff if it's otherwise enabled
    },
  },
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.pyright.setup({
      settings = {
        python = {
          pythonPath = "/Users/antoniogamizdelgado/Library/Caches/pypoetry/virtualenvs/badger-go-p6YDoiKT-py3.12/bin/python",
          autoImportCompletions = true,
        },
      },
    })

    lspconfig.tsserver.setup({})
  end,
}
