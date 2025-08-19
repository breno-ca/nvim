return {
  'akinsho/flutter-tools.nvim',
  lazy = false,

  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },

  config = function()
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

    require 'flutter-tools'.setup {
      widget_guides = {
        enabled = true,
      },
      debbugger = {
        enabled = true,
      },
      lsp = {
        capabilities = capabilities,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = 'prompt',
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
    }
  end,
}
