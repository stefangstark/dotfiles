lvim.keys.normal_mode["<Tab>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprev<cr>"
-- lvim.keys.normal_mode["<c-r>"] = ":FzfLua command_history<cr>"
vim.cmd("nnoremap gl $")
vim.cmd("nnoremap gh ^")
lvim.keys.normal_mode["\\\\"] = "<cmd> lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>"

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

vim.api.nvim_set_keymap("n", "f", ":HopChar1<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "t", ":HopPattern<cr>", { silent = true })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {silent = true, noremap = true})

lvim.builtin.which_key.mappings["lh"] = {
  "<cmd>lua require('lsp_signature').toggle_float_win()<cr>", "Toggle LSP signatures"
}

lvim.builtin.which_key.mappings["sg"] = {
  "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Search for string under cursor"
}

lvim.builtin.which_key.mappings["ss"] = {
  "<cmd>lua require('telescope.builtin').git_files()<cr>", "Search git repo"
}

lvim.builtin.which_key.mappings["sd"] = {
  "<cmd> lua require('telescope.builtin').find_files({follow = true, no_ignore = true})<cr>", "Seach all files",
}

lvim.builtin.which_key.mappings["sS"] = {
  "<cmd> lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Search in buffer",
}



-- vim.keymap.set("n", "ee", ':exec &bg=="light"? "set bg=dark" : "set bg=light"<cr>', {noremap = true, silent = true})
-- vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory"})

vim.keymap.set("n", "-", function()
  vim.cmd("vsplit | wincmd l")
  require("oil").open()
end)
