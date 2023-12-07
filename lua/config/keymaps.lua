-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "v", "i", "o" }, "<C-S-c>", "<Esc>")

map(
  "n",
  "<leader>Ccr",
  ":w<CR>:!gcc % -o %<.exe && %<<CR>",
  { noremap = true, silent = true, desc = "[C]ompile and [R]un" }
)

map(
  { "n", "v" },
  "gh",
  "^",
  { noremap = true, silent = true, desc = "Move to the first non-blank character of the line" }
)
map(
  { "n", "v" },
  "gl",
  "g_",
  { noremap = true, silent = true, desc = "Move to the last non-blank character of the line" }
)
map({ "n", "v" }, "gH", "0", { noremap = true, silent = true, desc = "Move to the first character of the line" })
map({ "n", "v" }, "gL", "$", { noremap = true, silent = true, desc = "Move to the last character of the line" })
map({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
map(
  { "n", "v" },
  "<leader>p",
  "_p",
  { noremap = true, silent = true, desc = "Paste without replacing the current register" }
)

map("i", ";d", function()
  function DeleteInInsert()
    local save = { selection = vim.o.selection, virtualedit = vim.o.virtualedit }
    vim.o.selection = "inclusive"
    vim.o.virtualedit = "onemore"
    local command = "d"
    local target = "`[v`]"
    local commands = target .. command
    vim.cmd("silent noautocmd keepjumps normal! " .. commands)
    vim.o.selection = save.selection
    vim.o.virtualedit = save.virtualedit
  end
  vim.o.opfunc = "v:lua.DeleteInInsert"
  return "<C-o>g@"
end, { noremap = true, silent = true, expr = true })
map("i", "<C-h>", "<Left>", { noremap = true, silent = true, desc = "Move left in insert mode" })
map("i", "<C-l>", "<Right>", { noremap = true, silent = true, desc = "Move right in insert mode" })
map("i", "<A-h>", "<BS>", { noremap = true, silent = true, desc = "Erase character in insert mode" })
map("i", "<A-l>", "<Space>", { noremap = true, silent = true, desc = "Insert space in insert mode" })
