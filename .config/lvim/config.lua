-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.keys.normal_mode["<Tab>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprev<cr>"

lvim.colorscheme = 'onenord'

-- install plugins
lvim.plugins = {
  "rmehri01/onenord.nvim",
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({
        style = 'cool'
      })
      require('onedark').load()
    end
  },
  "AckslD/swenv.nvim",
  "stevearc/dressing.nvim"

}

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

-- lvim.builtin.treesitter.ensure_installed = {
--   "python",
-- }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", args = { "--max-line-length=89" }, filetypes = { "python" } } }

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" },  { name = 'isort' } }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }



require('swenv').setup({
  post_set_venv = function()
    vim.cmd("LspRestart")
  end,
})

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
