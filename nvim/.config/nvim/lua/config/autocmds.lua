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
