-- this is some message
-- Set (local) mapleader key to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set (relative) line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Hide current mode, as it will be shown in custom status bar
vim.o.showmode = false

-- sync nvim and OS clipboard
-- This option is put in a scheduled function so it does not block startup
vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

-- turn off wrap, which makes breakindent useless
-- might want to change this up some day and see how it feels ;)
vim.o.wrap = true
vim.o.breakindent = false

-- save undo history in a file, undos saved between sessions
-- nicked from theprimeagen :)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- case-insensitive searches
-- unless \C is added to search string
vim.o.ignorecase = true
-- search becomes case senitive when pattern containes uppercase letters
vim.o.smartcase = true

-- column for lsp/git signs
vim.o.signcolumn = 'yes'

--see :help updatetime for what is does haha
vim.o.updatetime = 250

-- set timeout length for mappings
vim.o.timeoutlen = 500

-- set how windows split
vim.o.splitright = true
vim.o.splitbelow = true

-- set how tabs, spaces and other whitespace is displayed
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitution, among others live
vim.o.inccommand = 'split'

-- show line cursor is in
vim.o.cursorline = true

-- number of screen lines to keep above and below the cursor
vim.o.scrolloff = 8
-- number of columns to keep left and right of the cursor
vim.o.sidescrolloff = 16

-- vim raise dialog when performing operation that would otherwise fail
-- see :help confirm haha
vim.o.confirm = true

-- Turn off highlights during search
vim.o.hlsearch = false
-- Show live highlighting of closest matching search
vim.o.incsearch = true

-- enable 24-bit colors in terminal
vim.o.termguicolors = true

-- set tabs to 4 spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
-- auto-indent amount
vim.o.shiftwidth = 4
-- replace spaces with tabs when equal to tab_amount
vim.o.expandtab = true

-- auto-indent for some languages
vim.o.smartindent = true
