return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',

	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzf-native.nvim',
	},

	config = function()
		local telescope = require 'telescope'

		telescope.setup({
			defaults = {
				filesize_limit = 2,

				layout_config = {
					scroll_speed = 3,
					horizontal = { preview_width = 0.60 }
				},

				preview = {
					treesitter = { enable = true }
				}
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_file_sorter = true,
					case_mode = 'smart_case',
				}
			}
		})

		telescope.load_extension 'fzf'
		telescope.load_extension 'luasnip'
	end
}
