local python = require("plugins.languages.python")
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      local python_config = require("plugins.languages.python")
      python_config.setup_dap(dap)

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- Toggle breakpoint
      vim.keymap.set("n", "<leader>dd", function()
        dap.toggle_breakpoint()
      end, { noremap = true, silent = true, desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<C-S-d>", function()
        dap.toggle_breakpoint()
      end, { noremap = true, silent = true, desc = "Toggle breakpoint" })

      -- Continue / Start
      vim.keymap.set("n", "<leader>dc", function()
        dap.continue()
      end, { noremap = true, silent = true, desc = "Continue" })
      vim.keymap.set("n", "<C-S-c>", function()
        require("dap").continue()
      end, { noremap = true, silent = true, desc = "Continue" })

      -- Step Over
      vim.keymap.set("n", "<leader>do", function()
        dap.step_over()
      end, { noremap = true, silent = true, desc = "Step Over (Control + Shift + o)" })
      vim.keymap.set("n", "<C-S-o>", function()
        require("dap").step_over()
      end, { noremap = true, silent = true, desc = "Step over" })

      -- Step Into
      vim.keymap.set("n", "<leader>di", function()
        dap.step_into()
      end, { noremap = true, silent = true, desc = "Step into (Control + Shift + i)" })
      vim.keymap.set("n", "<C-S-i>", function()
        require("dap").step_into()
      end, { noremap = true, silent = true, desc = "Step Into" })

      -- Keymap to terminate debugging
      vim.keymap.set("n", "<leader>dq", function()
        require("dap").terminate()
        require("dapui").close()
      end, { noremap = true, silent = true, desc = "Terminate" })

      -- Toggle DAP UI
      vim.keymap.set("n", "<leader>du", function()
        dapui.toggle()
      end, { noremap = true, silent = true, desc = "Toggle UI" })
      vim.keymap.set("n", "<C-S-u>", function()
        dapui.toggle()
      end, { noremap = true, silent = true, desc = "Step Into" })

      -- DEBUG TEST UNDER CURSOR
      vim.keymap.set("n", "<leader>dt", function()
        local ext = vim.fn.expand("%:e")

        if ext == "py" then
          python_config.handle_run_test()
        end
      end, { noremap = true, silent = true, desc = "Debug test under cursor" })
    end,
  },
}
