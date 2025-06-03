return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',

	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzf-native.nvim',
	},

	config = function()
		local telescope = require 'telescope'
		local select_one_or_multi = function(prompt_bufnr)
			local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
			local multi = picker:get_multi_selection()
			if not vim.tbl_isempty(multi) then
				require('telescope.actions').close(prompt_bufnr)
				for _, j in pairs(multi) do
					if j.path ~= nil then
						vim.cmd(string.format('%s %s', 'edit', j.path))
					end
				end
			else
				require('telescope.actions').select_default(prompt_bufnr)
			end
		end

		telescope.setup {
			defaults = {
				filesize_limit = 2,

				mappings = { i = { ['<CR>'] = select_one_or_multi } },

				preview = { treesitter = { enable = true } },

				layout_config = {
					scroll_speed = 3,
					horizontal = { preview_width = 0.60 }
				},

			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_file_sorter = true,
					case_mode = 'smart_case',
				}
			}
		}

		telescope.load_extension 'fzf'
		telescope.load_extension 'luasnip'
	end
}
