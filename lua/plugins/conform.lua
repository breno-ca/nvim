return {
	'stevearc/conform.nvim',

	config = function()
		require 'conform'.setup {
			formatters_by_ft = {
				css = { 'prettier' },
				json = { 'prettier' },
				scss = { 'prettier' },
				html = { 'prettier' },
				markdown = { 'prettier' },
				htmlangular = { 'prettier' },
				javascript = { 'prettier' },
				typescript = { 'prettier' },
			},
			format_on_save = {
				lsp_format = "never",
			}
		}
	end,
}
