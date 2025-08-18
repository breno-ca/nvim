return {
  'monkoose/neocodeium',
  event = 'VeryLazy',

  config = function()
    require 'neocodeium'.setup {
      silent = true
    }
  end
}
