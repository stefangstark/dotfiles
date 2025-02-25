return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<S-CR>"] = { "select_and_accept", "fallback" },
      ["<C-l>"] = { "select_and_accept" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-h>"] = { "hide" },
    },
    completion = { list = { selection = { preselect = true, auto_insert = false } } },
    sources = {
      providers = {
        path = {
          opts = {
            get_cwd = function()
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },
  },
}
