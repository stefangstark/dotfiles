lvim.plugins = {
  -- { "nvim-treesitter/nvim-treesitter-context"  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "rmehri01/onenord.nvim",
    config = function()
      require('onenord').setup({
        disable={ background = true },
      })
    end
  },
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
  -- { "stevearc/dressing.nvim" },
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
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      -- "BufReadPre path/to/my-vault/**.md",
      -- "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/Documents/obsidian-vault/main/"
        },
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("oil").setup({
      columns = {"icon"},
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true
      },
    })
    end
  },
  {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})
  end
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

-- require("telescope").load_extension "file_browser"

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
