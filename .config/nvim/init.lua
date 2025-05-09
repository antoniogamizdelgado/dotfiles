-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("mason-lspconfig").setup({
  automatic_enable = {},
  ensure_installed = { "lua_ls" },
})
