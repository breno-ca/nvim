-- personalizações na UI
require 'barbar'.setup({
	auto_hide = true,
	exclude_name = { 'rightpad', 'leftpad' }
})
require 'gitsigns'.setup()
require 'nvim-tree'.setup({
	renderer = {
		indent_width = 2,
		highlight_diagnostics = "name",
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			show = { diagnostics = false },
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		severity = {
			min = vim.diagnostic.severity.ERROR,
			max = vim.diagnostic.severity.ERROR,
		},
	},
	view = {
		cursorline = true,
		preserve_window_proportions = true,
	},
	update_focused_file = {
		enable = true,
	},
	filters = {
		custom = { '.git' },
		exclude = { '.gitignore', '.github' },
	},
	git = {
		ignore = false,
	},
	sort = {
		sorter = "extension",
		folders_first = true,
		files_first = false,
	},
	live_filter = {
		prefix = "Filter:",
		always_show_folders = false,
	},
})

-- suporte a linguagens
require 'mason'.setup()
require 'mason-lspconfig'.setup()

--[[
Chamada setup() em ordem manual. Necessário para
alguns plugins funcionarem corretamente.
--]]
