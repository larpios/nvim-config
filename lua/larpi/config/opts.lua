vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.confirm = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.scrolloff = 100
if vim.fn.exists('+scrolloffpad') == 1 then
    vim.o.scrolloffpad = 1
end
vim.go.smarttab = true
vim.o.smartindent = true

vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.undofile = true
vim.o.undolevels = 5000

vim.go.updatetime = 250

vim.o.breakindent = true
vim.o.wrap = false
vim.o.swapfile = false

vim.o.hidden = true
vim.o.bufhidden = 'hide'

vim.o.signcolumn = 'yes'
vim.o.winborder = 'double'

vim.wo.conceallevel = 2

-- Set cursor shape to block in all modes
vim.o.guicursor = 'n-v-i-c:block'

-- Re-read files that have been modified outside of Vim
vim.o.autoread = true

-- It's already off, but just in case.
-- You should just use a dedicated completion plugin
vim.o.autocomplete = false

-- Open new windows to the right.
-- For example, opening a help page from a picker will open it to the right.
vim.o.splitright = true
vim.o.splitbelow = true

-- shada: limit history for faster startup
vim.o.shada = [[!,'100,f1,<50,s10,h]]

vim.o.shell = os.getenv('CURRENT_SHELL') or os.getenv('SHELL')

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

if vim.fn.has('win32') == 1 then
    vim.o.shellcmdflag = '-c'
    vim.o.shellquote = ''
    vim.o.shellxquote = ''
end
