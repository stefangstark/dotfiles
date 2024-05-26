lvim.plugins = {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  { "rmehri01/onenord.nvim"},
  {
    "AckslD/swenv.nvim",
    config = function()
      require('swenv').setup({
        post_set_venv = function()
          vim.cmd("LspRestart")
        end,
      })
    end
  },
  { "stevearc/dressing.nvim" },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  { "lervag/vimtex" },
  { "mfussenegger/nvim-dap-python" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestions = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
        require("nvim-tmux-navigation").setup {
            disable_when_zoomed = true, -- defaults to false
            keybindings = {
                left = "<C-h>",
                down = "<C-j>",
                up = "<C-k>",
                right = "<C-l>",
            }
        }
    end
  },
  {
    'smoka7/hop.nvim',
    version = '*', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuan' }
    end
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require"lsp_signature".on_attach() end,
  },
  {
    "VonHeikemen/fine-cmdline.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  {"kiyoon/telescope-insert-path.nvim"},
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
}

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    local ok, cmp = pcall(require, "copilot_cmp")
    if ok then cmp.setup({}) end
  end,
})

require("telescope").load_extension "file_browser"


-- Very clunky way to remove the buffer source from cmp
local new_sources = vim.tbl_filter(function(source)
  return not vim.tbl_contains({"path"}, source.name)
end, lvim.builtin.cmp.sources)

vim.list_extend(new_sources, {
  {
    name = "path",
    option={ get_cwd = function() return vim.fn.getcwd() end }
  },
})

lvim.builtin.cmp.sources = new_sources
