return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',

	config = function()
		local configs = require 'nvim-treesitter.configs'
		local api = vim.api -- Add this line to access Neovim API

		-- Function to get the language of a buffer
		local function get_language(bufnr)
			return vim.api.nvim_buf_get_option(bufnr, 'filetype')
		end

		-- Table of functions for each language
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
			-- Add more languages and their corresponding functions as needed
		}

		configs.setup {
			sync_install = false,
			ensure_installed = {
				'go', 'php', 'ruby', 'lua', 'javascript', 'dart',
				'sql', 'bash', 'html', 'yaml',
				'json', 'proto', 'css', 'make', 'dockerfile',
				'markdown', 'hurl', 'scheme', 'query',
			},

			indent = { enable = true },
			highlight = {
				enable = true,
				disable = function(lang, bufnr)
					local current_lang = get_language(bufnr)

					-- Look up the function for the current language in the table
					local func = language_functions[current_lang]

					-- If a function was found, call it and return its result
					if func then
						return func(bufnr)
					end

					-- If no function was found for the current language, return false
					return false
				end,
			},
			inject = {
				enable = true,
				languages = {
					javascript = { "css" },
					go = { "sql" },
					lua = { "query" },
				}
			},
		}
	end
}
