return {
  'jellydn/hurl.nvim',
  lazy = false,
  ft = 'hurl',

  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter'
  },

  opts = {
    debug = false,
    mode = 'popup',
    show_notification = false,
    file_root = vim.fn.getcwd(),

    formatters = {
      json = { 'jq' },
      html = { 'prettier', '--parser', 'html' },
      xml = { 'tidy', '-xml', '-i', '-q' },
    },
  },
}
