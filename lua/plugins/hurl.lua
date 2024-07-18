return {
	lazy = false,
	'jellydn/hurl.nvim',
	dependencies = {
		'MunifTanjim/nui.nvim',
		'nvim-lua/plenary.nvim',
		'nvim-treesitter/nvim-treesitter'
	},
	ft = 'hurl',
	opts = {

		debug = false,

		show_notification = false,
		mode = 'split',
		formatters = {
			json = { 'jq' },
			html = { 'prettier', '--parser', 'html' },
			xml = { 'tidy', '-xml', '-i', '-q' },
		},
	},
}
