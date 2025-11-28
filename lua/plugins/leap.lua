return {
  'ggandor/leap.nvim',
  lazy = false,
  config = function()
    require 'leap'.opts.vim_opts['go.ignorecase'] = true
  end
}
