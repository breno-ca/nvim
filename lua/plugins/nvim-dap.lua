return {
	'mfussenegger/nvim-dap',

	dependencies = {
		'rcarriga/nvim-dap-ui',
		'leoluz/nvim-dap-go',
		'nvim-neotest/nvim-nio',
		'theHamsta/nvim-dap-virtual-text',
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'
		local widgets = require 'dap.ui.widgets'
		local mason = os.getenv('HOME') .. '/.local/share/nvim/mason'

		dapui.setup {
			layouts = { {
				elements = {
					{ id = 'watches',     size = 0.25 },
					{ id = 'scopes',      size = 0.01 },
					{ id = 'breakpoints', size = 0.01 },
					{ id = 'repl',        size = 0.73 },
				}, size = 10, position = 'bottom',
			}, },
		}

		-- dap.listeners.before.attach.dapui_config = function() dapui.open() end
		dap.listeners.before.launch.dapui_config = function() dapui.open() end

		local n = 'n'

		vim.keymap.set(n, '<Leader>d', dapui.toggle, {})
		vim.keymap.set(n, '<Leader>3', dap.run_last, {})
		vim.keymap.set(n, '<Leader>4', dap.restart, {})
		vim.keymap.set(n, '<Leader>5', dap.continue, {})
		vim.keymap.set(n, '<Leader>6', dap.step_into, {})
		vim.keymap.set(n, '<Leader>7', dap.step_over, {})
		vim.keymap.set(n, '<Leader>8', dap.step_out, {})
		vim.keymap.set(n, '<Leader>b', dap.toggle_breakpoint, {})
		vim.keymap.set(n, '<Leader>k', widgets.hover, {})

		local last_test
		local testname = function()
			last_test = vim.fn.input('Type the full test name: ')
			return last_test
		end
		local relaunch_test = function() return last_test end

		dap.adapters.delve = {
			type = 'server',
			port = '${port}',
			executable = {
				command = 'dlv',
				args = { 'dap', '-l', '127.0.0.1:${port}', '--log' },
			}
		}
		dap.configurations.go = {
			{
				type = 'delve',
				name = 'Debug (main)',
				request = 'launch',
				outputMode = 'remote',
				mode = 'debug',
				program = '${workspaceFolder}/main.go',
			},
			{
				type = 'delve',
				name = 'Debug File',
				request = 'launch',
				outputMode = 'remote',
				mode = 'debug',
				program = '${file}',
			},
			{
				type = 'delve',
				name = 'Debug Test File',
				request = 'launch',
				outputMode = 'remote',
				mode = 'test',
				program = './${relativeFileDirname}',
			},
			{
				type = 'delve',
				name = 'Debug Test Function',
				request = 'launch',
				outputMode = 'remote',
				mode = 'test',
				args = {
					'-test.run',
					testname,
				},
				program = './${relativeFileDirname}',
			},
			{
				type = 'delve',
				name = 'Relaunch Debug Test Function',
				request = 'launch',
				outputMode = 'remote',
				mode = 'test',
				args = {
					'-test.run',
					relaunch_test,
				},
				program = './${relativeFileDirname}',
			},
		}

		dap.adapters.php = {
			type = 'executable',
			command = 'node',
			args = { os.getenv('HOME') .. '/vscode-php-debug/out/phpDebug.js' },
		}
		dap.configurations.php = {
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

		local pick_port_for_localhost = function()
			return 'http://localhost:' .. vim.fn.input('Port: ');
		end
		local windows_host_ip_from_wsl = function()
			local host = vim.fn.system('cat /etc/resolv.conf | grep nameserver | sed "s/nameserver //" | tr -d "\n"')
			return host
		end
		local launch_firefox_from_windows = function(url)
			local firefox_exe = [[/mnt/c/Program\ Files//Mozilla\ Firefox/firefox.exe]]
			vim.fn.system(firefox_exe .. ' -start-debugger-server -url ' .. url .. ' &')
			vim.fn.system('sleep 3')
		end
		local web_stack = {
			'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'htmlangular', 'scss', 'json'
		}
		dap.adapters.firefox = {
			type = 'executable',
			command = 'node',
			args = { mason .. '/packages/firefox-debug-adapter/dist/adapter.bundle.js' },
		}
		dap.adapters['pwa-node'] = {
			type = 'server',
			host = 'localhost',
			port = '${port}',
			executable = {
				command = 'node',
				args = { mason .. '/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
			}
		}
		for _, language in ipairs(web_stack) do
			dap.configurations[language] = {
				{
					name = "Launch file",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					name = 'Attach container',
					type = 'pwa-node',
					request = 'attach',
					cwd = '${workspaceFolder}',
					port = 9229,
					sourceMaps = true,
					restart = true,
					localRoot = '${workspaceFolder}',
					remoteRoot = '/usr/src/app',
				},
				{
					name = 'Start Firefox',
					type = 'firefox',
					request = 'launch',
					url = pick_port_for_localhost,
					webRoot = '${workspaceFolder}',
					reAttach = true,
				},
				{
					name = 'Start/Attach firefox.exe (WSL2 -> Windows)',
					type = 'firefox',
					request = 'attach',
					reAttach = true,
					host = function()
						local url = pick_port_for_localhost()
						launch_firefox_from_windows(url)
						return windows_host_ip_from_wsl()
					end,
					url = "http://localhost:3000", -- unused but mandatory to start
					webRoot = '${workspaceFolder}',
				},
				{
					name = 'Attach process',
					type = 'pwa-node',
					request = 'attach',
					processId = require 'dap.utils'.pick_process,
					cwd = '${workspaceFolder}',
				},
			}
		end
	end
}
