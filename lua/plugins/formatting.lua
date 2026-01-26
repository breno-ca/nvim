return {
  'stevearc/conform.nvim',

  config = function()
    require 'conform'.setup {
      formatters_by_ft = {
        html = { 'prettier' },
        css = { 'prettier' }
      },
      format_on_save = {
        lsp_format = 'never',
        timeout_ms = 2000,
      },
    }
  end
}
