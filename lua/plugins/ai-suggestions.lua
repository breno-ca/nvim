local github_copilot = {
  'github/copilot.vim',

  config = function()
    vim.g.copilot_no_tab_map = true

    keymap(i, '<A-;>', 'copilot#Accept("<CR>")', nsder('Apply suggestion'))
    keymap(i, '<A-Down>', 'copilot#Next()', nsder('Cycle to the next suggestion, if one is available'))
    keymap(i, '<A-Up>', 'copilot#Previous()', nsder('Cycle to the previous suggestion'))
    keymap(i, '<A-ç>', 'copilot#Suggest()', nsder('Explicitly request a suggestion'))
    keymap(i, '<A-Ç>', 'copilot#Dismiss()', nsder('Dismiss the current suggestion'))
  end
}

local windsurf = {
  'monkoose/neocodeium',
  event = 'VeryLazy',

  config = function()
    local neocodeium = require 'neocodeium'

    neocodeium.setup {
      silent = true
    }

    keymap(i, '<A-;>', call(neocodeium.accept), nsd('Apply suggestion'))
    keymap(i, '<A-Right>', call(neocodeium.accept_word), nsd('Accept word from suggestion'))
    keymap(i, '<A-Up>', call(neocodeium.cycle, -1), nsd('Cycle to the prevous suggestion'))
    keymap(i, '<A-Down>', call(neocodeium.cycle_or_complete, 1), nsd('Cycle to the next suggestion'))
    keymap(i, '<A-ç>', call(neocodeium.clear), nsd('Clear current suggestion'))
    keymap(n, '<Leader>ncc', '<Cmd>NeoCodeium chat<CR>', nsd('Open Codeium chat window'))
  end
}

local local_llm = {
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

local ai_suggestions = {
  github_copilot = github_copilot,
  windsurf = windsurf,
  local_llm = local_llm
}

return ai_suggestions[os.getenv('NVIM_AI_SUGGESTIONS_PROVIDER')] or windsurf
