return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "linux-cultist/venv-selector.nvim",
  },
  opts = {
    servers = {
      -- You can configure servers via lspconfig here if using other plugin integrations
      ruff_lsp = false, -- Disabling Ruff if it's otherwise enabled
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig/util")

    -- Function to get Python path from active Poetry environment
    local function get_python_path()
      
      -- Fallback: try to detect Poetry environment
      local poetry_python = vim.fn.trim(vim.fn.system("poetry env info -p 2>/dev/null")) .. "/bin/python"
      if vim.fn.executable(poetry_python) == 1 then
        return poetry_python
      end
      
      -- Final fallback: use system Python
      return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

    -- Setup Pyright with dynamic Python path
    lspconfig.pyright.setup({
      before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path()
      end,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
          autoImportCompletions = true,
        },
      },
    })

    lspconfig.tsserver.setup({})
  end,
}
