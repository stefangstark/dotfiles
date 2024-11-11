-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPre", "VimEnter" }, {
  pattern = "*.md",
  callback = function()
    local search = vim.fn.search("\\%^---", "n")
    if search == 0 then
      return
    end
    vim.cmd("normal! gg")
    vim.cmd("2/---/1")
    local old_option = vim.opt.scrolloff
    vim.opt.scrolloff = 0
    vim.cmd("normal! zt")
    vim.opt.scrolloff = old_option
  end,
})

--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.tex", "*.md" },
--   command = "hi Conceal guibg=NONE",
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.tex", "*.md" },
--   command = "setlocal wrap",
-- })
