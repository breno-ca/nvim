return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',

	config = function()
		local configs = require 'nvim-treesitter.configs'
		local api = vim.api -- Add this line to access Neovim API

		local function get_language(bufnr)
			return vim.api.nvim_buf_get_option(bufnr, 'filetype')
		end

		local language_functions = {
			html = function(bufnr)
				local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
				for _, line in ipairs(lines) do
					if #line > 2900 then
						return true
					end
				end
				return false
			end,
			json = function(bufnr)
				local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
				for _, line in ipairs(lines) do
					if #line > 2900 then
						return true
					end
				end
				return false
			end,
		}

		configs.setup {
			sync_install = false,
			ensure_installed = {
				'go', 'php', 'ruby', 'lua', 'javascript', 'dart',
				'sql', 'bash', 'html', 'yaml', 'vim',
				'json', 'proto', 'css', 'make', 'dockerfile',
				'markdown', 'hurl', 'scheme', 'query',
				'gomod', 'gosum',
			},

			indent = { enable = true },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,

				disable = function(lang, bufnr)
					local current_lang = get_language(bufnr)
					local func = language_functions[current_lang]

					if func then
						return func(bufnr)
					end
					return false
				end,
			},
			inject = {
				enable = true,
				languages = {
					javascript = { 'css' },
					go = { 'sql' },
					lua = { 'query', 'bash', 'vim' },
					bash = { 'bash' }
				}
			},
		}
	end
}
