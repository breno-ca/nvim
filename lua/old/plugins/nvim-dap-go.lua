return {
	"leoluz/nvim-dap-go",

	config = function()
		require "dap-go".setup {
			dap_configurations = {
				{
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
				{
					type = "go",
					name = "Debug (Build Flags)",
					request = "launch",
					program = "${file}",
					buildFlags = require("dap-go").get_build_flags,
				},
				{
					type = 'go',
					name = 'Debug (main)',
					request = 'launch',
					program = '${workspaceFolder}/main.go',
				},
				{
					type = 'go',
					name = 'Debug (main)',
					request = 'launch',
					program = '${workspaceFolder}/main.go',
					buildFlags = require("dap-go").get_build_flags,
				},
			},
			delve = {
				path = "dlv",
				initialize_timeout_sec = 20,
				port = "${port}",
				args = {},
				build_flags = {},
				detached = vim.fn.has("win32") == 0,
				cwd = nil,
			},
			tests = {
				verbose = false,
			},
		}
	end
}
