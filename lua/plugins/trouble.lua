local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-T>"] = trouble.open_with_trouble },
      n = { ["<c-T>"] = trouble.open_with_trouble },
    },
  },
}

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})
