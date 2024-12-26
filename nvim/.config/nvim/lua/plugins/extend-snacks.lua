return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { title = "Projects", section = "projects", indent = 1, padding = 2, gap = 1 },
        { section = "startup" },
      },
    },
  },
}
