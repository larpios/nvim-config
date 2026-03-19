vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.confirm = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.scrolloff = 100
vim.o.smarttab = true
vim.o.smartindent = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.undofile = true
vim.o.undolevels = 5000

vim.o.updatetime = 250

vim.o.breakindent = true
vim.o.wrap = true
vim.o.swapfile = false

vim.o.hidden = true
vim.o.bufhidden = 'hide'

vim.o.signcolumn = 'yes'
vim.o.winborder = 'double'

vim.wo.conceallevel = 2

vim.o.guicursor = 'n-v-i-c:block'

vim.o.autoread = true

-- shada: limit history for faster startup
vim.opt.shada = [[!,'100,f1,<50,s10,h]]

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

if vim.fn.has("win32") == 1 then
    vim.opt.shellcmdflag = "-c"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end
