return {
	'CopilotC-Nvim/CopilotChat.nvim',
	branch = 'canary',

	dependencies = {
		'github/copilot.vim',
		'nvim-lua/plenary.nvim',
	},

	config = function ()
		local copilot_chat = require('CopilotChat')
		local copilot_cmp = require('CopilotChat.integrations.cmp')

		copilot_chat.setup({
			question_header = '## Breno ',
			window = {
				layout = 'float',
				width = 0.8,
				height = 0.8,

				relative = 'editor',
				border = 'rounded',
				row = 3,
				title = '| Copilot Chat |  |',
			},
		})

		copilot_cmp.setup()
	end
}
