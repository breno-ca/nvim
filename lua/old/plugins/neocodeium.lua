return {
	'monkoose/neocodeium',
	event = 'VeryLazy',
	config = function()
		local neocodeium = require('neocodeium').setup()
		-- neocodeium = require('neocodeium').setup({
		-- 	silent = true,
		-- })
		--
		-- vim.cmd('NeoCodeium! disable')
	end
}
