vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.virtualedit = 'block'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.9
vim.g.python3_host_prog = os.getenv('HOME') .. '/python3/bin/python3.13'
vim.g.gitblame_enabled = 0
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set nofixendofline')
vim.cmd('set linebreak')
vim.cmd('set wrap!')
vim.cmd('set number')
vim.cmd("let mapleader = ' '")
vim.cmd('autocmd VimEnter * NvimTreeOpen')
vim.cmd('autocmd VimEnter * wincmd w')
if (vim.fn.exists(':CopilotChatLoad') == 1) then
  vim.cmd('autocmd VimEnter * CopilotChatLoad lastchat')
end

-- filetype extras
vim.filetype.add({
  filename = {
    ['docker-compose.yml'] = 'yaml.docker-compose',
  }
})

-- lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- init
require 'globals'
require 'lazy'.setup 'plugins'
require 'shortcuts'
require 'lsp'
