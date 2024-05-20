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

-- mode alias
local n = 'n'
local i = 'i'
local t = 't'
local ni = {'n', 'i'}
local nv = {'n', 'v'}
local nt = {'n', 't'}
-----------------------------------------------
-- neovim configurations

-- remapings
vim.keymap.set(n, '<Up>', 'gk', nsd('Move UP through virtual lines in NORMAL mode'))
vim.keymap.set(n, '<Down>', 'gj', nsd('Move DOWN through virtual lines in NORMAL mode'))
vim.keymap.set(i, '<Up>', '<C-o>gk', nsd('Move UP through virtual lines in INSERT mode'))
vim.keymap.set(i, '<Down>', '<C-o>gj', nsd('Move DOWN through virtual lines in INSERT mode'))

-- shortcuts
vim.keymap.set(ni, '<A-z>', '<C-o>u', nsd('Undo last change'))
vim.keymap.set(ni, '<A-Z>', '<C-o><C-r>', nsd('Redo last change'))
vim.keymap.set(ni, '<A-s>', '<Cmd>w<CR>', nsd('Save changes in current file'))
vim.keymap.set(n, '<A-S-k>', 'dd2kp', nsd('Move current line UP in Normal mode'))
vim.keymap.set(n, '<A-S-j>', 'ddp', nsd('Move current line DOWN in Normal mode'))
vim.keymap.set(i, '<A-S-k>', '<Esc>dd2kpi', nsd('Move current line UP in Insert mode'))
vim.keymap.set(i, '<A-S-j>', '<Esc>ddpi', nsd('Move current line UP in Insert mode'))

-----------------------------------------------
-- plugins configuration

-- nvim-tree
vim.keymap.set(n, '<S-A-w>', '<Cmd>NvimTreeToggle<CR>', nsd('Toggle files tree visibility'))
vim.keymap.set(n, '<A-w>', '<Cmd>NvimTreeFocus<CR>', nsd('Put the cursor in files tree'))

-- telescope
local builtin = require'telescope.builtin'
vim.keymap.set(n, '<A-e>', builtin.find_files, {})
vim.keymap.set(n, '<A-f>', builtin.live_grep, {})
vim.keymap.set(n, '<leader>fb', builtin.buffers, {})
vim.keymap.set(n, '<leader>fh', builtin.help_tags, {})

-- barbar tabline
vim.keymap.set(n, '<A-,>', '<Cmd>BufferPrevious<CR>', nsd('Go to the next tab'))
vim.keymap.set(n, '<A-.>', '<Cmd>BufferNext<CR>', nsd('Go to the previous tab'))
vim.keymap.set(n, '<A-<>', '<Cmd>BufferMovePrevious<CR>', nsd('Move the current tab to the left'))
vim.keymap.set(n, '<A->>', '<Cmd>BufferMoveNext<CR>', nsd('Move the current tab to the right'))
vim.keymap.set(n, '<A-p>', '<Cmd>BufferPin<CR>', nsd('Pin the current tab'))
vim.keymap.set(n, '<A-c>', '<Cmd>BufferClose<CR>', nsd('Close the current tab'))
vim.keymap.set(n, '<C-p>', '<Cmd>BufferPick<CR>', nsd('Pick the current tab'))
vim.keymap.set('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', nsd('Order tabs by filename'))
vim.keymap.set('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', nsd('Order tabs by directory name'))
-- vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', nsd) -- Can be used to configure any tab number
-- vim.keymap.set('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', nsd('Order tabs by the display tab name'))
-- vim.keymap.set('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', nsd('Orger tabs by language'))
-- vim.keymap.set('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', nsd('Order tabs by window number'))

-- trouble
local trouble = require'trouble'
vim.keymap.set(n, '<Space>xx', function() trouble.toggle() end, nsd('Toggle trouble window'))
vim.keymap.set(n, '<Space>xw', function() trouble.toggle("workspace_diagnostics") end, nsd('Show workspace diagnostics'))
vim.keymap.set(n, '<Space>xd', function() trouble.toggle('document_diagnostics') end, nsd('Show current document diagnostics'))
vim.keymap.set(n, '<Space>xq', function() trouble.toggle('quickfix') end, nsd('Show quickfixes'))
vim.keymap.set(n, '<Space>xl', function() trouble.toggle('loclist') end, nsd('Show loclist'))
vim.keymap.set(n, 'gR', function() trouble.toggle('lsp_references') end, nsd('Show LSP references'))

-- nvim-dap
local dap = require'dap'
local dapui = require'dapui'
local widgets = require'dap.ui.widgets'
vim.keymap.set(n, '<F5>', function() dap.continue() end, nsd('Continue/Start Debug Session'))
vim.keymap.set(n, '<F10>', function() dap.step_over() end, nsd('Step Over'))
vim.keymap.set(n, '<F11>', function() dap.step_into() end, nsd('Step Into'))
vim.keymap.set(n, '<F12>', function() dap.step_out() end, nsd('Step Out'))
vim.keymap.set(n, '<A-b>', function() dap.toggle_breakpoint() end, nsd('Toggle Breakpoint'))
vim.keymap.set(n, '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, nsd('Set Breakpoint with a Message'))
vim.keymap.set(n, '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set(n, '<S-F5>', function() dap.run_last() end, nsd('Restart Last Debug Session'))
vim.keymap.set(nv, '<Leader>dh', function() widgets.hover() end, nsd('Displays a variable value in a floating window'))
vim.keymap.set(nv, '<Leader>dp', function() widgets.preview() end, nsd('Displays a variable value in a preview window'))
vim.keymap.set(n, '<Leader>df', function() widgets.centered_float(widgets.frames) end, nsd('Opens the contents of the widget in a floating window'))
vim.keymap.set(n, '<Leader>ds', function() widgets.centered_float(widgets.scopes) end, nsd('Opens the contents of the widget in a floating window'))
vim.keymap.set(n, '<A-S-D>', function() dapui.toggle({}) end, nsd('Show/Hide Debug Window Visibility'))

-- floaterm
vim.keymap.set(nt, '<A-\'>', '<Cmd>:FloatermToggle<CR>', nsd('Toggle terminal'))
vim.keymap.set(nt, '<A-">', '<Cmd>:FloatermNew<CR>', nsd('Open a new terminal session'))
vim.keymap.set(t, '<A-1>', '<Cmd>:FloatermPrev<CR>', nsd('Go to the next terminal'))
vim.keymap.set(t, '<A-2>', '<Cmd>:FloatermNext<CR>', nsd('Go to the previous terminal'))
