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
  "AckslD/swenv.nvim",
  "stevearc/dressing.nvim",
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },

--   {
--   "kevinhwang91/nvim-bqf",
--   event = { "BufRead", "BufNew" },
--   config = function()
--   require("bqf").setup({
--           auto_enable = true,
--           preview = {
--           win_height = 12,
--           win_vheight = 12,
--           delay_syntax = 80,
--           border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
--           },
--           func_map = {
--           vsplit = "",
--           ptogglemode = "z,",
--           stoggleup = "",
--           },
--           filter = {
--           fzf = {
--           action_for = { ["ctrl-s"] = "split" },
--           extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
--           },
--           },
--           })
--   end,
-- },

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
linters.setup {
  { command = "flake8", args = { "--max-line-length=89" }, filetypes = { "python" } },
  { command = "shellcheck" }
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" },  { name = 'isort' } }
-- formatters.shfmt.with({
--   extra_args = {"-i", "2", "-sr", "-s", "-ci"}
-- })
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

-- Fixes highlighting for active quickfix line
local colors vim.api.nvim_create_augroup("vimrc_colors", { clear = true })
vim.api.nvim_create_autocmd({'ColorScheme'}, {
  pattern = "*",
  group = colors,
  command = "hi QuickFixLine guibg=NONE"

})


vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set('n', '<cr>', ':noh<cr><cr>', { noremap = true, silent = true })
