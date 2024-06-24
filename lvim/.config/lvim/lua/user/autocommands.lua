vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*.md",
  callback = function()
    local search = vim.fn.search('\\%^---', 'n')
    if search == 0 then
      return
    end
    vim.cmd("2/---/2")
    local old_option = vim.opt.scrolloff
    vim.opt.scrolloff = 0
    vim.cmd("normal! zt")
    vim.opt.scrolloff = old_option
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.tex", "*.md" },
  command = "hi Conceal guibg=NONE"
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.tex", "*.md" },
  command = "setlocal wrap"
})
