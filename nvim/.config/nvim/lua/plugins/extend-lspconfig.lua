return {
  "neovim/nvim-lspconfig",
  lazy = false,
  opts = {
    servers = {
      ruff = {
        init_options = {
          settings = {
            lint = {
              enable = false,
            },
          },
        },
      },
      texlab = {
        settings = {
          texlab = {
            inlayHints = {
              labelReferences = false,
              labelDefinitions = false,
            },
          },
        },
      },
    },
  },
}
