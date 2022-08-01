vim.opt.clipboard = 'unnamedplus'
vim.opt.ignorecase = true
vim.opt.lazyredraw = true
vim.opt.updatetime = 100
vim.opt.guicursor = ''

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append('c')

vim.opt.colorcolumn = '80'

vim.g.mapleader = ' '

-- Custom dashboard
local db = require 'dashboard'
db.custom_header = {
	'',
	'',
	'',
	'',
	' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
	' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
	' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
	' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
	' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
	' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
	'',
	'',
	'',
}
db.custom_center = {
	{
		icon = ' ',
		desc = 'New File            ',
		action = 'DashboardNewFile',
		shortcut = 'SPC o',
	},
	{
		icon = ' ',
		desc = 'Browse Files        ',
		action = 'Telescope file_browser',
		shortcut = 'SPC n',
	},
	{
		icon = ' ',
		desc = 'Find File           ',
		action = 'Telescope find_files',
		shortcut = 'SPC f',
	},
	{
		icon = ' ',
		desc = 'Configure Neovim    ',
		action = 'edit ~/.config/nvim/lua/init.lua',
		shortcut = 'SPC v',
	},
	{
		icon = ' ',
		desc = 'Exit Neovim         ',
		action = 'quit',
    shortcut = 'SPC q',
	},
}
