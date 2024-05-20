return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.6',

	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzf-native.nvim',
	},

	config = function()
		local telescope = require'telescope'

		telescope.setup({
			extensions = {
				fzf = {
					fuzzy = true,
					override_file_sorter = true,
					case_mode = 'smart_case',
				}
			}
		})

		telescope.load_extension'fzf'
		telescope.load_extension'luasnip'
	end
}
