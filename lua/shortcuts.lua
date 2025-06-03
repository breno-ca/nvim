-----------------------------------------------
-- configurations helper

-- noremap, silent, description
local function nsd(description)
	return { noremap = true, silent = true, desc = description }
end

-- function caller with arguments
local function call(func, args)
	return function() func(args) end
end

-- mode alias
local n = 'n'
local i = 'i'
local t = 't'
local v = 'v'
local ni = { n, i }
local nv = { n, v }
local xo = { 'x', 'o' }
local ntv = { n, t, v }
local niv = { n, i, v }

local keymap = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts)
end

-----------------------------------------------
-- neovim configurations

-- remapings
keymap(n, '<Up>', 'gk', nsd('Move UP through virtual lines in NORMAL mode'))
keymap(n, '<Down>', 'gj', nsd('Move DOWN through virtual lines in NORMAL mode'))
keymap(i, '<Up>', '<C-o>gk', nsd('Move UP through virtual lines in INSERT mode'))
keymap(i, '<Down>', '<C-o>gj', nsd('Move DOWN through virtual lines in INSERT mode'))
keymap(n, ';', '/', nsd('Search forward in NORMAL mode'))
keymap(i, '<Esc>', '<Esc><Cmd>w<CR>', nsd('Save file on exit from INSERT mode'))

-----------------------------------------------
-- shortcuts

-- neovim actions
keymap(n, '<Leader>vl', '<Cmd>set wrap!<CR>', nsd('Toggle line wrapping'))

-- code actions
keymap(n, '<A-i>', call(vim.diagnostic.open_float), nsd('Inspect diagnostics'))
keymap(ni, '<A-a>', call(vim.lsp.buf.code_action), nsd('Show code actions menu'))
-- moving lines
keymap(n, '<A-k>', 'ddkP', nsd('Move current line UP in NORMAL mode'))
keymap(n, '<A-j>', 'ddp', nsd('Move current line DOWN in NORMAL mode'))
keymap(i, '<A-k>', '<Esc>ddkPi', nsd('Move current line UP in INSERT mode'))
keymap(i, '<A-j>', '<Esc>ddpi', nsd('Move current line UP in INSERT mode'))
-- adding lines
keymap(i, '<A-CR>', '<C-o>o', nsd('Add a new line below in INSERT mode'))
keymap(i, '<A-]>', '<C-o>O', nsd('Add a new line in INSERT mode'))
-- formatting
keymap(v, '<Leader>fj', ':!jq .<CR>', nsd('Format JSON in visual mode'))



-- buffer actions
keymap(niv, '<C-z>', '<Cmd>undo<CR>', nsd('Undo last change'))
keymap(niv, '<C-Z>', '<Cmd>redo<CR>', nsd('Redo last change'))
-- keymap(niv, '<C-s>', '<Cmd>w<CR>', nsd('Save changes in current file'))
keymap(nv, '<Leader><Esc>', '<Cmd>w<CR>', nsd('Save changes in current file'))
-- buffer splitting
keymap(n, '<Leader>sd', '<Cmd>vsplit<CR><Cmd>wincmd l<CR>', nsd('Split buffer window vertically'))
keymap(n, '<Leader>sx', '<Cmd>split<CR><Cmd>wincmd j<CR>', nsd('Split buffer window horizontally'))
keymap(n, '<Leader>S', '<Cmd>wincmd x<CR>', nsd('Swap buffer windows'))
-- buffer sizing
keymap(n, '<A-->', '<C-w><', nsd('Decrease buffer window width'))
keymap(n, '<A-=>', '<C-w>>', nsd('Increase buffer window width'))
keymap(n, '<A-S-->', '<C-w>-', nsd('Decrease buffer window height'))
keymap(n, '<A-S-=>', '<C-w>+', nsd('Increase buffer window height'))
-- buffer movement
keymap(n, '<Leader><Leader>', '<Cmd>wincmd w<CR>', nsd('Cycle through buffers'))
keymap(n, '<Leader><Up>', '<Cmd>wincmd k<CR>', nsd('Move to the buffer above'))
keymap(n, '<Leader><Down>', '<Cmd>wincmd j<CR>', nsd('Move to the buffer below'))
keymap(n, '<Leader><Left>', '<Cmd>wincmd h<CR>', nsd('Move to the buffer on the left'))
keymap(n, '<Leader><Right>', '<Cmd>wincmd l<CR>', nsd('Move to the buffer on the right'))
keymap(n, '<Leader>qw', '<Cmd>wincmd q<CR>', nsd('Close buffer window'))

-- quit
keymap(n, '<Leader>qa', '<Cmd>qa<CR>', nsd('Safe quit'))

-----------------------------------------------
-- plugins

-- nvim-tree
keymap(n, '<Leader>w', '<Cmd>NvimTreeOpen<CR>', nsd('Toggle files tree visibility'))

-- telescope
local telescope = require 'telescope.builtin'
keymap(n, '<Leader>f', telescope.find_files, nsd('Search files by name'))
keymap(n, '<Leader>gf', telescope.live_grep, nsd('Search files with live grep'))
keymap(n, '<Leader>gs', telescope.git_status, nsd('Search through git status'))
keymap(n, '<Leader>sr', telescope.lsp_references, nsd('Show LSP references'))
keymap(n, '<Leader><CR>', telescope.lsp_implementations, nsd('Show LSP implementation'))
keymap(n, '<Leader>tr', telescope.resume, nsd('Resume latest search'))

-- barbar tabline
keymap(n, '<A-,>', '<Cmd>BufferPrevious<CR>', nsd('Go to the next tab'))
keymap(n, '<A-.>', '<Cmd>BufferNext<CR>', nsd('Go to the previous tab'))
keymap(n, '<A-S-,>', '<Cmd>BufferMovePrevious<CR>', nsd('Move the current tab to the left'))
keymap(n, '<A-S-.>', '<Cmd>BufferMoveNext<CR>', nsd('Move the current tab to the right'))
keymap(n, '<Leader>qq', '<Cmd>BufferClose<CR>', nsd('Close the current tab'))

-- trouble
keymap(n, '<Leader>tw', '<Cmd>Trouble diagnostics toggle focus=true<CR>', nsd('Show workspace diagnostics'))
keymap(n, '<Leader>td', '<Cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>',
	nsd('Show current document diagnostics'))
keymap(n, '<Leader>tf', '<Cmd>Trouble quickfix toggle focus=true<CR>', nsd('Show quickfixes'))

-- floaterm
keymap(ntv, '<A-\'>', '<Cmd>:FloatermToggle<CR>', nsd('Toggle terminal'))
keymap(ntv, '<A-3>', '<Cmd>:FloatermNew<CR>', nsd('Open a new terminal session'))
keymap(ntv, '<A-1>', '<Cmd>:FloatermPrev<CR>', nsd('Go to the next terminal'))
keymap(ntv, '<A-2>', '<Cmd>:FloatermNext<CR>', nsd('Go to the previous terminal'))
keymap(t, '<A-q>', '<Cmd>:FloatermKill<CR>', nsd('Kill the current terminal'))

-- copilot chat
keymap(nv, '<Leader>cc', '<Cmd>CopilotChatToggle<CR>', nsd('Open Copilot chat window'))
keymap(nv, '<Leader>cs', '<Cmd>CopilotChatStop<CR>', nsd('Stop Prompt Generation'))
keymap(nv, '<Leader>cm', '<Cmd>CopilotChatModels<CR>', nsd('Choose model for Copilot chat'))

-- zen mode
keymap(n, '<Leader>zm', '<Cmd>ZenMode<CR>', nsd('Toggle Zen mode'))

-- hurl
local hurl_set_env_file = function() vim.cmd('HurlSetEnvFile ' .. vim.fn.input('Environment file: ')) end
keymap(n, '<Leader>r', '<Cmd>HurlRunnerAt<CR>', nsd('Run API request'))
keymap(n, '<Leader>hv', '<Cmd>HurlManageVariable<CR>', nsd('Manage Hurl variables'))
keymap(n, '<Leader>hef', call(hurl_set_env_file), nsd('Set Hurl environment file'))
keymap(nv, '<Leader>hr', '<Cmd>HurlRunner<CR>', nsd('Run all requests'))
keymap(n, '<Leader>hte', '<Cmd>HurlRunnerToEntry<CR>', nsd('Run API request to entry'))
keymap(n, '<Leader>htm', '<Cmd>HurlToggleMode<CR>', nsd('Toggle Hurl mode'))
keymap(n, '<Leader>htv', '<Cmd>HurlVerbose<CR>', nsd('Run API in verbose mode'))
keymap(n, '<Leader>hlr', '<Cmd>HurlShowLastResponse<CR>', nsd('Show last response'))

-- leap
keymap(n, 's', '<Plug>(leap)', nsd('Leap to a word'))
keymap(n, 'S', '<Plug>(leap-from-window)', nsd('Leap to a word from another window'))
keymap(xo, 's', '<Plug>(leap-forward)', nsd('Leap to a word forward '))
keymap(xo, 'S', '<Plug>(leap-backward)', nsd('Leap to a word backward'))

-- gitblame
keymap(n, '<Leader>gb', '<Cmd>GitBlameToggle<CR>', nsd('Toggle gitblame comments visibility'))

-- ccc
keymap(n, '<Leader>cp', '<Cmd>CccPick<CR>', nsd('Color picker'))
keymap(n, '<Leader>cvc', '<Cmd>CccConvert<CR>', nsd('Convert color'))

-- peek
keymap(n, '<Leader>mdo', '<Cmd>PeekOpen<CR>', nsd('Peek open'))
keymap(n, '<Leader>mdc', '<Cmd>PeekClose<CR>', nsd('Peek close'))
