Dap = require 'dap'
Dapui = require 'dapui'
Virtual = require 'nvim-dap-virtual-text'

local testname = function()
	return vim.fn.input('Type the full test name: ')
end

------------------ GO ------------------
Dap.adapters.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'dlv',
		args = { 'dap', '-l', '127.0.0.1:${port}' },
	}
}

Dap.configurations.go = {
	{
		type = 'delve',
		name = 'Debug',
		request = 'launch',
		program = '${file}',
	},
	{
		type = 'delve',
		name = 'Debug test',
		request = 'launch',
		mode = 'test',
		program = './${relativeFileDirname}',
	},
	{
		type = 'delve',
		name = 'Debug test function',
		request = 'launch',
		mode = 'test',
		args = {
			'-test.run',
			testname,
		},
		program = './${relativeFileDirname}',
	},
}
------------------ GO ------------------

------------------ PHP ------------------
Dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = { os.getenv('HOME') .. '/vscode-php-debug/out/phpDebug.js' },
}

-- reescreva a configuração para debug php
Dap.configurations.php = {
	{
		type = 'php',
		request = 'launch',
		name = 'Debug',
		program = vim.fn.expand('%:p'),
		cwd = vim.fn.expand('%:p:h'),
		port = 9003,
	}
}
------------------ PHP ------------------

Virtual.setup({})

Dapui.setup({
	layouts = {
		{
			elements = {
				{
					id = "stacks",
					size = 0.25
				}, {
				id = "watches",
				size = 0.25
			}, {
				id = "breakpoints",
				size = 0.25
			}, {
				id = "scopes",
				size = 0.25
			}
			},
			position = "right",
			size = 40
		},
		{
			elements = {
				{
					id = "console",
					size = 0.25
				},
				{
					id = "repl",
					size = 0.75
				},

			},
			position = "bottom",
			size = 10
		}
	}
})

Dap.listeners.before.attach.dapui_config = function()
	Dapui.open()
end

Dap.listeners.before.launch.dapui_config = function()
	Dapui.open()
end
