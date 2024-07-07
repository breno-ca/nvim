Dap = require 'dap'
Dapui = require 'dapui'
Virtual = require 'nvim-dap-virtual-text'

local last_test
local testname = function()
	last_test = vim.fn.input('Type the full test name: ')
	return last_test
end
local relaunch_test = function()
	return last_test
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
	{
		type = 'delve',
		name = 'Relaunch Debug test function',
		request = 'launch',
		mode = 'test',
		args = {
			'-test.run',
			relaunch_test,
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
		name = 'Debug PHP 8.3 (Start builtin server)',
		port = 9003,
		runtimeArgs = {
			'-S', 'localhost:8080'
		},
		preLaunchTask = {
			type = 'shell',
			command = 'php -S localhost:8080',
			presentation = {
				reveal = 'always',
				panel = 'new',
			},
			group = {
				kind = 'build',
				isDefault = true,
			},
		},
	},
	{
		type = 'php',
		request = 'launch',
		name = 'Debug Laravel (PHP 8.3)',
		port = 9003,
		runtimeArgs = {
			'artisan', 'serve',
		},
		preLaunchTask = {
			type = 'shell',
			command = 'php artisan serve',
			presentation = {
				reveal = 'always',
				panel = 'new',
			},
			group = {
				kind = 'build',
				isDefault = true,
			},
		},
		postDebugTask = {
			type = 'shell',
			command = 'kill $(lsof -t -i :8000)',
		},

	},
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
