-----------------------------------------------
-- configurations helper

-- noremap, silent, description
local function nsd(description)
	return {
		noremap = true,
		silent = true,
		desc = description,
	}
end

-- noremap, silent, description, expression, replace keycodes
local function nsder(description)
	return {
		noremap = true,
		silent = true,
		desc = description,
		expr = true,
		replace_keycodes = false,
	}
end

-- function caller with arguments
local function call(func, args)
	return function()
		func(args)
	end
end

-- -- vimscript input wrapper
-- local function vimscript_input(vimscript)
-- 	return function ()
-- 		local input = '("' .. vim.fn.input('Request suggestion: ') .. '")'
-- 		return vimscript .. input
-- 	end
-- end

-- mode alias
local n = 'n'
local i = 'i'
local t = 't'
local ni = { 'n', 'i' }
local nv = { 'n', 'v' }
local ntv = { 'n', 't', 'v' }
local niv = { 'n', 'i', 'v' }
-- local nitv = {'n', 'i', 't', 'v'}


-----------------------------------------------
-- neovim configurations

-- remapings
vim.keymap.set(n, '<Up>', 'gk', nsd('Move UP through virtual lines in NORMAL mode'))
vim.keymap.set(n, '<Down>', 'gj', nsd('Move DOWN through virtual lines in NORMAL mode'))
vim.keymap.set(i, '<Up>', '<C-o>gk', nsd('Move UP through virtual lines in INSERT mode'))
vim.keymap.set(i, '<Down>', '<C-o>gj', nsd('Move DOWN through virtual lines in INSERT mode'))


-----------------------------------------------
-- shortcuts

-- undo
vim.keymap.set(niv, '<A-z>', '<Cmd>undo<CR>', nsd('Undo last change'))

-- redo
vim.keymap.set(niv, '<A-Z>', '<Cmd>redo<CR>', nsd('Redo last change'))

-- save
vim.keymap.set(niv, '<A-s>', '<Cmd>w<CR>', nsd('Save changes in current file'))

-- inspect diagnostic messages
vim.keymap.set(n, '<A-i>', call(vim.diagnostic.open_float), nsd('Inspect diagnostics'))

-- show lsp actions
vim.keymap.set(ni, '<A-a>', call(vim.lsp.buf.code_action), nsd('Show code actions menu'))

-- moving lines
vim.keymap.set(n, '<A-k>', 'dd2kp', nsd('Move current line UP in NORMAL mode'))
vim.keymap.set(n, '<A-j>', 'ddp', nsd('Move current line DOWN in NORMAL mode'))
vim.keymap.set(i, '<A-k>', '<Esc>dd2kpi', nsd('Move current line UP in INSERT mode'))
vim.keymap.set(i, '<A-j>', '<Esc>ddpi', nsd('Move current line UP in INSERT mode'))

-- adding lines
vim.keymap.set(i, '<A-CR>', '<C-o>o', nsd('Go to a new line below current line in INSERT mode'))
vim.keymap.set(i, '<A-]>', '<C-o>O', nsd('Add a new line in current line in INSERT mode'))


-----------------------------------------------
-- plugins

-- nvim-tree
vim.keymap.set(n, '<A-w>', '<Cmd>NvimTreeFocus<CR>', nsd('Put the cursor in files tree'))
vim.keymap.set(n, '<A-S-w>', '<Cmd>NvimTreeToggle<CR>', nsd('Toggle files tree visibility'))

-- telescope
local telescope = require 'telescope.builtin'
vim.keymap.set(n, '<A-e>', telescope.find_files, nsd('Search files by name'))
vim.keymap.set(n, '<A-E>', telescope.git_status, nsd('Search through git status'))
vim.keymap.set(n, '<A-f>', telescope.live_grep, nsd('Search files with live grep'))
vim.keymap.set(n, '<A-u>', telescope.lsp_references, nsd('Show LSP references'))
vim.keymap.set(n, '<A-I>', telescope.lsp_implementations, nsd('Show LSP implementation'))

-- barbar tabline
vim.keymap.set(n, '<A-,>', '<Cmd>BufferPrevious<CR>', nsd('Go to the next tab'))
vim.keymap.set(n, '<A-.>', '<Cmd>BufferNext<CR>', nsd('Go to the previous tab'))
vim.keymap.set(n, '<A-<>', '<Cmd>BufferMovePrevious<CR>', nsd('Move the current tab to the left'))
vim.keymap.set(n, '<A->>', '<Cmd>BufferMoveNext<CR>', nsd('Move the current tab to the right'))
vim.keymap.set(n, '<A-q>', '<Cmd>BufferClose<CR>', nsd('Close the current tab'))

-- trouble
vim.keymap.set(n, '<Leader>w', '<Cmd>Trouble diagnostics toggle focus=true<CR>', nsd('Show workspace diagnostics'))
vim.keymap.set(n, '<Leader>d', '<Cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>',
	nsd('Show current document diagnostics'))
vim.keymap.set(n, '<Leader>q', '<Cmd>Trouble quickfix toggle focus=true<CR>', nsd('Show quickfixes'))

-- nvim-dap
local dap = require 'dap'
local dapui = require 'dapui'
local widgets = require 'dap.ui.widgets'
local loginput = function() dap.set_breakpoint(nil, nil, vim.fn.input('Log message: ')) end
vim.keymap.set(n, '<F5>', call(dap.continue), nsd('Continue/Start Debug Session'))
vim.keymap.set(n, '<F6>', call(dap.restart), nsd('Restart Debug Session'))
vim.keymap.set(n, '<F10>', call(dap.step_over), nsd('Step Over'))
vim.keymap.set(n, '<F11>', call(dap.step_into), nsd('Step Into'))
vim.keymap.set(n, '<F12>', call(dap.step_out), nsd('Step Out'))
vim.keymap.set(n, '<A-b>', call(dap.toggle_breakpoint), nsd('Toggle Breakpoint'))
vim.keymap.set(n, '<A-S-b>', loginput, nsd('Toggle Logpoint'))
vim.keymap.set(n, '<S-F5>', call(dap.run_last), nsd('Restart Last Debug Session'))
vim.keymap.set(nv, '<A-h>', call(widgets.hover), nsd('Displays a variable value in a floating window'))
vim.keymap.set(n, '<A-S-D>', call(dapui.toggle), nsd('Show/Hide Debug Window Visibility'))

-- floaterm
vim.keymap.set(ntv, '<A-\'>', '<Cmd>:FloatermToggle<CR>', nsd('Toggle terminal'))
vim.keymap.set(ntv, '<A-">', '<Cmd>:FloatermNew<CR>', nsd('Open a new terminal session'))
vim.keymap.set(t, '<A-1>', '<Cmd>:FloatermPrev<CR>', nsd('Go to the next terminal'))
vim.keymap.set(t, '<A-2>', '<Cmd>:FloatermNext<CR>', nsd('Go to the previous terminal'))

-- copilot
vim.keymap.set(i, '<A-;>', 'copilot#Accept("<CR>")', nsder('Open Copilot'))
vim.keymap.set(i, '<A-Down>', 'copilot#Next()', nsder('Cycle to the next suggestion, if one is available'))
vim.keymap.set(i, '<A-Up>', 'copilot#Previous()', nsder('Cycle to the previous suggestion'))
vim.keymap.set(i, '<A-ç>', 'copilot#Suggest()', nsder('Explicitly request a suggestion'))
vim.keymap.set(i, '<A-Ç>', 'copilot#Dismiss()', nsder('Dismiss the current suggestion'))

-- copilot-chat
vim.keymap.set(nv, '<Leader>cc', '<Cmd>CopilotChatToggle<CR>', nsd('Toggle Copilot Chat'))
vim.keymap.set(n, '<Leader>cs', '<Cmd>CopilotChatStop<CR>', nsd('Stop Copilot Chat'))
