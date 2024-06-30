return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',

	config = function()
		local configs = require 'nvim-treesitter.configs'

		configs.setup {
			ensure_installed = {
				'dockerfile', 'gitignore', 'go', 'gomod', 'gowork',
				'javascript', 'json', 'lua', 'markdown', 'proto',
				'python', 'ruby', 'sql', 'yaml', 'php', 'html', 'css',
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		}
	end
}
