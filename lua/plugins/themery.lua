return {
	'zaldih/themery.nvim',

	dependencies = {
		{ 'EdenEast/nightfox.nvim' },
		{ 'mhartington/oceanic-next' },
		{ 'srcery-colors/srcery-vim' },
		{ 'Shatur/neovim-ayu' },
		{ 'navarasu/onedark.nvim' },
		{ 'sainnhe/edge' },
		{ 'sainnhe/sonokai' },
		{ 'sainnhe/everforest' },
		{ 'rebelot/kanagawa.nvim' },
		{ 'folke/tokyonight.nvim',   tag = 'v4.9.0' },
		{ 'catppuccin/nvim' },
	},

	config = function()
		local edge_opts = function(style) return "vim.g.edge_style = '" .. style .. "'" end
		local onedark_opts = function(style) return "vim.g.onedark_config = { style = '" .. style .. "' }" end
		local sonokai_opts = function(style) return "vim.g.sonokai_style = '" .. style .. "'" end
		local everforest_opts = function(style, bg)
			return "vim.g.everforest_background = '" .. style .. "'; vim.o.background = '" .. bg .. "'"
		end
		require 'themery'.setup({
			themes = {
				{ name = 'Default',                          colorscheme = 'default' },
				{ name = 'Tokyonight               | Dark',  colorscheme = 'tokyonight' },
				{ name = 'Tokyonight (Night)       | Dark ', colorscheme = 'tokyonight-night' },
				{ name = 'Tokyonight (Storm)       | Dark',  colorscheme = 'tokyonight-storm' },
				{ name = 'Tokyonight (Moon)        | Dark',  colorscheme = 'tokyonight-moon' },
				{ name = 'Duskfox                  | Dark',  colorscheme = 'duskfox' },
				{ name = 'Nordfox                  | Dark',  colorscheme = 'nordfox' },
				{ name = 'Carbonfox                | Dark',  colorscheme = 'carbonfox' },
				{ name = 'Srcery                   | Dark',  colorscheme = 'srcery' },
				{ name = 'OneDark                  | Dark',  colorscheme = 'onedark',             before = onedark_opts("dark") },
				{ name = 'OneDark (Darker)         | Dark',  colorscheme = 'onedark',             before = onedark_opts("darker") },
				{ name = 'Ayu                      | Dark',  colorscheme = 'ayu-dark' },
				{ name = 'Ayu (Mirage)             | Dark',  colorscheme = 'ayu-mirage' },
				{ name = 'Edge Dark                | Dark',  colorscheme = 'edge',                before = edge_opts("default") },
				{ name = 'Edge Dark (Aura)         | Dark',  colorscheme = 'edge',                before = edge_opts("aura") },
				{ name = 'Edge Dark (Neon)         | Dark',  colorscheme = 'edge',                before = edge_opts("neon") },
				{ name = 'Everforest (Soft)        | Dark',  colorscheme = 'everforest',          before = everforest_opts("soft", "dark") },
				{ name = 'Everforest (Medium)      | Dark',  colorscheme = 'everforest',          before = everforest_opts("medium", "dark") },
				{ name = 'Everforest (Hard)        | Dark',  colorscheme = 'everforest',          before = everforest_opts("hard", "dark") },
				{ name = 'Kanagawa (Dragon)        | Dark',  colorscheme = 'kanagawa-dragon' },
				{ name = 'Sonokai                  | Dark',  colorscheme = 'sonokai',             before = sonokai_opts("default") },
				{ name = 'Sonokai (Atlantis)       | Dark',  colorscheme = 'sonokai',             before = sonokai_opts("atlantis") },
				{ name = 'Sonokai (Andromeda)      | Dark',  colorscheme = 'sonokai',             before = sonokai_opts("andromeda") },
				{ name = 'Catppuccin Frappe        | Dark',  colorscheme = 'catppuccin-frappe' },
				{ name = 'Catppuccin Macchiato     | Dark',  colorscheme = 'catppuccin-macchiato' },
				{ name = 'Catppuccin Mocha         | Dark',  colorscheme = 'catppuccin-mocha' },
				{ name = 'Nightfox                 | Blue',  colorscheme = 'nightfox' },
				{ name = 'Terafox                  | Blue',  colorscheme = 'terafox' },
				{ name = 'Oceanic                  | Blue',  colorscheme = 'OceanicNext' },
				{ name = 'OneDark (Cool)           | Blue',  colorscheme = 'onedark',             before = onedark_opts("cool") },
				{ name = 'OneDark (Deep)           | Blue',  colorscheme = 'onedark',             before = onedark_opts("deep") },
				{ name = 'Sonokai (Maia)           | Blue',  colorscheme = 'sonokai',             before = sonokai_opts("maia") },
				{ name = 'OneDark (Warm)           | Warm',  colorscheme = 'onedark',             before = onedark_opts("warm") },
				{ name = 'OneDark (Warmer)         | Warm',  colorscheme = 'onedark',             before = onedark_opts("warmer") },
				{ name = 'Kanagawa                 | Warm',  colorscheme = 'kanagawa-wave' },
				{ name = 'Sonokai (Shusia)         | Warm',  colorscheme = 'sonokai',             before = sonokai_opts("shusia") },
				{ name = 'Sonokai (Espresso)       | Warm',  colorscheme = 'sonokai',             before = sonokai_opts("espresso") },
				{ name = 'Kanagawa (Lotus)         | Light', colorscheme = 'kanagawa-lotus' },
				{ name = 'Everforest (Soft)        | Light', colorscheme = 'everforest',          before = everforest_opts("soft", "light") },
				{ name = 'Everforest (Medium)      | Light', colorscheme = 'everforest',          before = everforest_opts("medium", "light") },
				{ name = 'Everforest (Hard)        | Light', colorscheme = 'everforest',          before = everforest_opts("hard", "light") },
				{ name = 'Tokyonight (Day)         | Light', colorscheme = 'tokyonight-day' },
				{ name = 'Dayfox                   | Light', colorscheme = 'dayfox' },
				{ name = 'Dawnfox                  | Light', colorscheme = 'dawnfox' },
				{ name = 'OneDark (Light)          | Light', colorscheme = 'onedark',             before = onedark_opts("light") },
				{ name = 'Ayu (Light)              | Light', colorscheme = 'ayu-light' },
				{ name = 'Edge Light               | Light', colorscheme = 'edge',                before = edge_opts("light") },
				{ name = 'Catppuccin Latte         | Light', colorscheme = 'catppuccin-latte' },
			}
		})
	end
}
