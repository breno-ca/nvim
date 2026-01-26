return {
  'L3MON4D3/LuaSnip',
  tag = 'v2.3.0',

  dependencies = {
    'rafamadriz/friendly-snippets',
    'benfowler/telescope-luasnip.nvim',
  },

  config = function()
    require 'luasnip'.config.set_config {
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
    }
    require 'luasnip.loaders.from_vscode'.lazy_load()
  end
}
