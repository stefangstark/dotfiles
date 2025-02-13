-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "U", "<cmd>redo<cr>", {
  desc = "Re-do",
  remap = true,
})

vim.keymap.set({ "n", "x", "s", "i" }, "<c-;>", "<cmd>w<cr><esc>", {
  desc = "Save file",
  remap = true,
})
