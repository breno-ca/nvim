-- personalizações na UI
require'barbar'.setup()
require'gitsigns'.setup()
require'nvim-tree'.setup({
	view = { preserve_window_proportions = true },
	filters = {
		custom = { '.git' },
		exclude = { '.gitignore' },
	},
	git = {
		ignore = false,
	},
	sort = {
        sorter = "extension",
        folders_first = true,
        files_first = false,
	},
})

-- suporte a linguagens
require'mason'.setup()
require'mason-lspconfig'.setup()

--[[
Chamada setup() em ordem manual. Necessário para
alguns plugins funcionarem corretamente.
--]]
