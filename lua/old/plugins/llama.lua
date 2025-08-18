return {
  'ggml-org/llama.vim',

  init = function()
    vim.g.llama_config = {
      endpoint = 'http://localhost:11434/infill',
      show_info = false,

      keymap_trigger = '<A-ç>',
      keymap_accept_full = '<A-;>',
      keymap_accept_word = '<A-Right>',
      keymap_accept_line = '<A-Down>'
    }
  end
}
