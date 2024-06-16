local dap = require'dap'
local dapui = require'dapui'
local virtual = require'nvim-dap-virtual-text'
-- local dlv = vim.fn.exepath('/home/breno-ca/go/bin/dlv')
local testname = function ()
	return vim.fn.input('Type the full test name: ')
end

dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

dap.configurations.go = {
	{
		type = 'delve',
		name = 'Debug',
		request = 'launch',
		program = '${file}',
	},
	-- works with go.mod packages and sub packages 
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
			-- ' -- ',
			'-test.run',
			testname,
		},
		program = './${relativeFileDirname}',
	},
}
-- 
-- dap.configurations.go = {
-- 	{
-- 	    type = 'go';
-- 	    name = 'Debug';
-- 	    request = 'launch';
-- 	    showLog = false;
-- 	    program = "${file}";
-- 	    dlvToolPath = dlv;
-- 	},
-- 	{
-- 		type = 'go';
-- 		name = 'Debug Test Function';
-- 		request = 'launch';
-- 		mode = 'test';
-- 		showLog = false;
-- 		program = "${workspaceFolder}";
-- 		args = {
-- 			'-test.run',
-- 			'MyTestFunction'
-- 		};
-- 		dlvToolPath = dlv;
-- 	},
-- 	{
-- 		type = 'go';
-- 		name = 'Debug Test';
-- 		request = 'launch';
-- 		mode = 'debug';
-- 		showLog = false;
-- 		program = "${fileDirname}";
-- 		dlvToolPath = dlv;
-- 	},
-- }
-- 
virtual.setup({})

dapui.setup({
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
					id = "repl",
					size = 1
				}
			},
			position = "bottom",
			size = 10
		}
	}
})

dap.listeners.before.attach.dapui_config = function ()
	dapui.open()
end

dap.listeners.before.launch.dapui_config = function ()
	dapui.open()
end

-- dap.listeners.before.event_terminated.dapui_config = function ()
-- 	dapui.close()
-- end

-- dap.listeners.before.event_exited.dapui_config = function ()
-- 	dapui.close()
-- end
