-- Format keymap("mode", "shotcut", "action")
-- Testing
vim.api.nvim_set_keymap("n", "<leader>tt", ":TestNearest<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "t", ":FindTest<CR>", { noremap = true, silent = true })

-- Save and then normal mode
vim.api.nvim_set_keymap("n", "<C-s>", ":w <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })

-- Go to end of line
vim.keymap.set("i", "<C-Right>", "<End>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", "$", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "$", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "^", { noremap = true, silent = true })

-- Go to start of the line
vim.keymap.set("i", "<C-Left>", "<C-o>^", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", "^", { noremap = true, silent = true })

-- LSP
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "<leader>rr", function()
  local old = vim.fn.input("Find: ")
  local new = vim.fn.input("Replace with: ")
  if old ~= "" then
    vim.cmd(string.format("%%s/%s/%s/gc", old, new))
  end
end, { noremap = true, silent = false })

vim.api.nvim_set_keymap("n", "<C-e>", "<C-^>", { noremap = true, silent = true, desc = "Go to last file" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
