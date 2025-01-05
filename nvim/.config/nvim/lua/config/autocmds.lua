-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "VimEnter", "BufReadPre", "FileType" }, {
  pattern = "*.md",
  callback = function()
    local search = vim.fn.search("\\%^---", "n")
    if search == 0 then
      return
    end
    vim.cmd("normal! gg")
    vim.cmd("2/---/1")
    vim.opt_local.scrolloff = 0
    vim.cmd("normal! zt")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "PersistenceSavePre",
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local bufpath = vim.api.nvim_buf_get_name(buf) .. "/"
      if bufpath:match("^" .. vim.pesc("/private/tmp")) then
        vim.api.nvim_buf_delete(buf, {})
      end
    end
  end,
})

vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_option_value("titlestring", "vim " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~"), {})
    -- vim.api.nvim_set_option_value("titlestring", vim.fn., opts)
  end,
})
