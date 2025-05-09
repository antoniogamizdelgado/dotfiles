local M = {}

-- Function to get Python path from Poetry environment
function M.get_python_path()
  return vim.fn.trim(vim.fn.system("poetry run which python"))
end

-- Function to setup Python LSP
function M.setup_lsp(lspconfig)
  lspconfig.pyright.setup({
    settings = {
      python = {
        pythonPath = M.get_python_path(),
      },
    },
  })
end

-- Function to setup Python DAP
function M.setup_dap(dap)
  dap.adapters.python = {
    type = "executable",
    command = M.get_python_path(),
    args = { "-m", "debugpy.adapter" },
  }

  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = M.get_python_path(),
    },
    {
      type = "python",
      request = "launch",
      name = "Django",
      program = "${workspaceFolder}/manage.py",
      args = { "runserver", "0.0.0.0:8000" },
      django = true,
      pythonPath = M.get_python_path(),
    },
  }
end

function M.handle_run_test()
  local full_path = vim.fn.expand("%:p")
  local rel_path = vim.fn.fnamemodify(full_path, ":~:.")

  local module_path = rel_path:gsub("/", "."):gsub("%.py$", "")
  local function_name = vim.fn.expand("<cword>")

  local is_django_test = false
  for line in io.lines(full_path) do
    if string.match(line, "from django.test import TestCase") then
      is_django_test = true
      break
    end
  end

  local test_class = nil
  local current_line = vim.fn.line(".")
  for i = current_line, 1, -1 do
    local line = vim.fn.getline(i)
    local class_name = line:match("^%s*class%s+([%w_]+)%s*%b():")
    if class_name then
      test_class = class_name
      break
    end
  end

  local test_target
  if function_name:match("^test_") then
    if test_class then
      test_target = is_django_test and (module_path:gsub("%.", "/") .. ".py::" .. test_class .. "::" .. function_name)
        or (module_path .. "." .. test_class .. "." .. function_name)
    else
      test_target = is_django_test and (module_path:gsub("%.", "/") .. ".py::" .. function_name)
        or (module_path .. "." .. function_name)
    end
  else
    test_target = module_path
  end

  if is_django_test then
    require("dap").run({
      type = "python",
      request = "launch",
      name = "Debug Django Test",
      program = vim.fn.getcwd() .. "/manage.py",
      args = { "test", test_target, "--keepdb" },
      django = true,
    })
  else
    require("dap").run({
      type = "python",
      request = "launch",
      name = "Debug unittest",
      module = "unittest",
      args = { test_target },
    })
  end
end

return M
