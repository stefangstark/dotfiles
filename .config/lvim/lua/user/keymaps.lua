lvim.keys.normal_mode["<Tab>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprev<cr>"

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

lvim.builtin.which_key.mappings["x"] = {
  name = "Trouble & todo-comments",
  x = { "<cmd>lua require('trouble').toggle()<cr>", "Toggle trouble" },
  w = { "<cmd>lua require('trouble').toggle('workspace_diagnostics')<cr>", "Workplace diagnostics" },
  d = { "<cmd>lua require('trouble').toggle('document_diagnostics')<cr>", "Document diagnostics" },
  q = { "<cmd>lua require('trouble').toggle('quickfix')<cr>", "Quickfix" },
  l = { "<cmd>lua require('trouble').toggle('loclist')<cr>", "Loclist" },
}

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.lsp.buffer_mappings.normal_mode["gr"] = {
  ":lua require'telescope.builtin'.lsp_references()<cr>",
  "Find references"
}

lvim.lsp.buffer_mappings.normal_mode["gd"] = {
  ":lua vim.lsp.buf.definition()<cr>",
  -- ":lua require'telescope.builtin'.lsp_definitions()<cr>",
  " Definitions"
}

lvim.lsp.buffer_mappings.normal_mode["gD"] = {
  ":lua vim.lsp.buf.type_definition()<cr>",
  " Type Definition"
}

vim.api.nvim_set_keymap("n", "f", ":HopChar1<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "t", ":HopPattern<cr>", { silent = true })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {silent = true, noremap = true})
