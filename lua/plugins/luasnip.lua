return {
	'L3MON4D3/LuaSnip',
	tag = 'v2.3.0',

	dependencies = {
		'rafamadriz/friendly-snippets',
		'benfowler/telescope-luasnip.nvim',
	},

	opts = {
		history = true,
		updateevents = 'TextChanged,TextChangedI',
	},

	config = function(_, opts)
		require'luasnip'.config.setup(opts)
		require'luasnip.loaders.from_vscode'.lazy_load()
	end
}
