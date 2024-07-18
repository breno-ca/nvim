-- configurações do nvim
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.9
vim.g.python3_host_prog = '/usr/local/bin/python3.12'
vim.cmd('set nofixendofline')
vim.cmd('set linebreak')
vim.cmd('set number')
-- vim.opt.noequalalways = true

vim.cmd('autocmd VimEnter * NvimTreeOpen')
vim.cmd('autocmd VimEnter * wincmd w')

-- configurações recomendadas para o nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- lazy.nvim para gerenciamento de plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- carrega os plugins da pasta
require 'lazy'.setup 'plugins'

-- carrega os atalhos globais personalizados
require 'shortcuts'

-- carrega as funções para alterar a fonte
require 'fonts'

-- carrega os setups necessários
require 'setup'

-- carrega o suporte a linguagens
require 'setup-lsp'

-- carrega as configurações de debug
require 'setup-dap'
