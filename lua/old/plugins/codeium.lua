return {
	'Exafunction/codeium.vim',

	event = 'BufEnter',

	config = function()
		vim.g.codeium_disable_bindings = true
		vim.g.codeium_virtual_text_priority = 10000
	end
}

-- 	'Exafunction/codeium.nvim',
--
-- 	dependencies = {
-- 		'nvim-lua/plenary.nvim',
-- 		'hrsh7th/nvim-cmp'
-- 	},
--
-- 	config = function()
-- 		require 'codeium'.setup {
-- 			enable_chat = true
-- 		}
-- 	end
-- }
