return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local lspconfig = require("lspconfig")

    local python_config = require("plugins.languages.python")
    python_config.setup_lsp(lspconfig)
    lspconfig.lua_ls.setup({})
    lspconfig.tsserver.setup({})
  end,
}
