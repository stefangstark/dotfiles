local pyright_opts = {
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      -- reportGeneralTypeIssues = false,
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace", -- openFilesOnly, workspace
        typeCheckingMode = "off",     -- off, basic, strict
        useLibraryCodeForTypes = true
      }
    }
  },
}

require("lvim.lsp.manager").setup("pyright", pyright_opts)

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8",    args = { "--max-line-length=89", "--extend-ignore=F" }, filetypes = { "python" } },
  { command = "shellcheck" }
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, { name = 'isort' } }


