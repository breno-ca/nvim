return {
	'zaldih/themery.nvim',

	config = function()
		themes = {
			{ name = 'Default',                          colorscheme = 'default' },
			{ name = 'Tokyonight               | Dark',  colorscheme = 'tokyonight' },
			{ name = 'Tokyonight (Night)       | Dark ', colorscheme = 'tokyonight-night' },
			{ name = 'Tokyonight (Storm)       | Dark',  colorscheme = 'tokyonight-storm' },
			{ name = 'Tokyonight (Moon)        | Dark',  colorscheme = 'tokyonight-moon' },
			{ name = 'Duskfox                  | Dark',  colorscheme = 'duskfox' },
			{ name = 'Nordfox                  | Dark',  colorscheme = 'nordfox' },
			{ name = 'Carbonfox                | Dark',  colorscheme = 'carbonfox' },
			{ name = 'NeoSolarized             | Dark',  colorscheme = 'NeoSolarized' },
			{ name = 'Nightfox                 | Blue',  colorscheme = 'nightfox' },
			{ name = 'Terafox                  | Blue',  colorscheme = 'terafox' },
			{ name = 'Hivacruz                 | Blue',  colorscheme = 'hivacruz' },
			{ name = 'Night Owl                | Blue',  colorscheme = 'night-owl' },
			{ name = 'Tokyonight (Day)         | Light', colorscheme = 'tokyonight-day' },
			{ name = 'Dayfox                   | Light', colorscheme = 'dayfox' },
			{ name = 'Dawnfox                  | Light', colorscheme = 'dawnfox' },
		}
		require 'themery'.setup(themes)
	end
}
