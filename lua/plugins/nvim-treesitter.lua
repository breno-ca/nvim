return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',

	config = function()
		local configs = require 'nvim-treesitter.configs'

		configs.setup {
			ensure_installed = {
				'go', 'php', 'ruby', 'lua', 'javascript',
				'sql', 'bash', --[['html',--]] 'yaml',
				'json', 'proto', 'css', 'make',
				'markdown',
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },

		}
	end
}
