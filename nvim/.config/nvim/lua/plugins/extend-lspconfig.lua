return {
  "neovim/nvim-lspconfig",
  lazy = false,
  opts = {
    servers = {
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
