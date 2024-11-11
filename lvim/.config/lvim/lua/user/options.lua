vim.opt.relativenumber = true

lvim.builtin.project.detection_methods = { "lsp", "pattern" }
lvim.builtin.project.patterns = {
  ".git",
  "package-lock.json",
  "yarn.lock",
  "package.json",
  "requirements.txt",
}

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

lvim.builtin.nvimtree.setup.filters.custom = { "node_modules", ".cache", "__pycache__", "__init__.py" }
lvim.builtin.telescope.defaults.path_display = { "absolute" }

vim.opt.conceallevel = 2
vim.opt.scrolloff = 0
vim.g.python3_host_prog = "/usr/bin/python3"
