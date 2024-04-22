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

local path_actions = require("telescope_insert_path")
lvim.builtin.telescope.defaults.mappings.n = {
  ["{"] = path_actions.insert_relpath_insert,
}
