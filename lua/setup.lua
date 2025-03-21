-- personalizações na UI
require 'barbar'.setup({
	auto_hide = true,
	exclude_name = { 'rightpad', 'leftpad' }
})
require 'gitsigns'.setup()
-- require 'nvim-tree'.setup({
-- 	renderer = {
-- 		indent_width = 2,
-- 		highlight_diagnostics = "name",
-- 		indent_markers = {
-- 			enable = true,
-- 			inline_arrows = true,
-- 			icons = {
-- 				corner = "└",
-- 				edge = "│",
-- 				item = "│",
-- 				bottom = "─",
-- 				none = " ",
-- 			},
-- 		},
-- 		icons = {
-- 			show = { diagnostics = false },
-- 		},
-- 	},
-- 	diagnostics = {
-- 		enable = true,
-- 		show_on_dirs = true,
-- 		severity = {
-- 			min = vim.diagnostic.severity.ERROR,
-- 			max = vim.diagnostic.severity.ERROR,
-- 		},
-- 	},
-- 	view = {
-- 		width = 30,
-- 		cursorline = true,
-- 		preserve_window_proportions = true,
-- 		adaptive_size = true,
-- 	},
-- 	update_focused_file = {
-- 		enable = true,
-- 	},
-- 	filters = {
-- 		dotfiles = false,
-- 		custom = { '^.git$' },
-- 	},
-- 	sort = {
-- 		sorter = "suffix",
-- 		folders_first = true,
-- 	},
-- 	live_filter = {
-- 		prefix = "Filter:",
-- 		always_show_folders = false,
-- 	},
-- 	-- actions = {
-- 	-- 	open_file = {
-- 	-- 		resize_window = false,
-- 	-- 	},
-- 	-- },
-- })

-- suporte a linguagens
require 'mason'.setup()
require 'mason-lspconfig'.setup()

--[[
Chamada setup() em ordem manual. Necessário para
alguns plugins funcionarem corretamente.
--]]
