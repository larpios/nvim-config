vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.confirm = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 100
vim.opt.smarttab = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.undofile = true
vim.opt.undolevels = 5000

vim.opt.updatetime = 250

vim.opt.breakindent = true
vim.opt.wrap = true
vim.opt.swapfile = false

vim.opt.hidden = true
vim.opt.bufhidden = 'hide'

vim.opt.signcolumn = 'yes'
vim.opt.winborder = 'double'

vim.wo.conceallevel = 2

-- Set cursor shape to block in all modes
vim.opt.guicursor = 'n-v-i-c:block'

-- Re-read files that have been modified outside of Vim
vim.opt.autoread = true

-- It's already off, but just in case.
-- You should just use a dedicated completion plugin
vim.opt.autocomplete = false

-- Open new windows to the right.
-- For example, opening a help page from a picker will open it to the right.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- shada: limit history for faster startup
vim.opt.shada = [[!,'100,f1,<50,s10,h]]

vim.opt.shell = os.getenv('CURRENT_SHELL') or os.getenv('SHELL')

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

if vim.fn.has('win32') == 1 then
    vim.opt.shellcmdflag = '-c'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = ''
end
