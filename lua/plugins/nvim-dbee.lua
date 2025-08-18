return {
  'kndndrj/nvim-dbee',
  commit = '512a5764d2c59880f1d13cda32e67070b25589c8',

  dependencies = {
    'MunifTanjim/nui.nvim',
  },

  build = function() require 'dbee'.install('curl') end,
  config = function() require 'dbee'.setup() end,
}
