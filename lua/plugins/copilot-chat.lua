local github_copilot = {
  'CopilotC-Nvim/CopilotChat.nvim',
  tag = 'v3.12.2',

  dependencies = { 'nvim-lua/plenary.nvim' },
  build = 'make tiktoken',

  opts = {
    log_level = 'error',
    model = 'gpt-5-mini',
    language = 'Brazilian Portuguese',
    question_header = '## Breno ',
    window = {
      layout = 'float',
      width = 0.8,
      height = 0.8,
      relative = 'editor',
      border = 'rounded',
      row = 3,
    },
    selection = function(source)
      local select = require 'CopilotChat.select'
      local empty_out = {
        bufnr = 0,
        content = '',
        diagnostics = nil,
        end_line = 0,
        filename = '',
        filetype = '',
        start_line = 1,
      }
      return select.visual(source) or empty_out
    end,
  }
}

local local_llm = {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  build = 'make tiktoken',

  opts = function()
    local utils = require 'CopilotChat.utils'
    local select = require 'CopilotChat.select'
    local providers = require 'CopilotChat.config.providers'

    local ggufs = '/home/breno-ca/gguf/'
    local model = 'qwen2.5-coder-3b-i.gguf'

    local system_prompt = [[
      You are:
      - a programming assistant.

      You MUST:
      - help with code.
      - answer briefly and objectively.
      - focus only on the problem presented.
      - explain your answers only if requested.
      - avoid unnecessary comments.
      - always respond in Brazilian Portuguese.

      Main technologies:
      - Go
      - Angular
    ]]

    local embed = function(inputs, headers)
      local response, err = utils.curl_post(
        'http://localhost:11434/embeddings',
        {
          headers = headers,
          json_request = true,
          json_response = true,
          body = { input = inputs, model = 'all-minilm' },
        }
      )
      if err then error(err) end
      return response.body.data
    end
    local get_url = function() return 'http://localhost:11434/chat/completions' end
    local get_models = function(headers)
      local response, err = utils.curl_get(
        'http://localhost:11434/models',
        { headers = headers, json_response = true }
      )
      if err then error(err) end
      return vim.tbl_map(function(model) return { id = model.id, name = model.id } end, response.body.data)
    end
    return {
      log_level = 'error',
      model = ggufs .. model,
      system_prompt = system_prompt,
      question_header = '## Breno ',
      window = {
        title = '| llama.cpp Chat | ' .. model .. ' |',
        layout = 'float',
        relative = 'editor',
        width = 0.8,
        height = 0.8,
        border = 'rounded',
        row = 3,
      },
      selection = function(source)
        local empty_out = {
          bufnr = 0,
          content = '',
          diagnostics = nil,
          end_line = 0,
          filename = '',
          filetype = '',
          start_line = 1,
        }
        return select.visual(source) or empty_out
      end,
      providers = {
        github_models = { disabled = true },
        ollama = {
          prepare_input = providers.copilot.prepare_input,
          prepare_output = providers.copilot.prepare_output,
          embed = embed,
          get_url = get_url,
          get_models = get_models,
        }
      }
    }
  end
}

local ai_chat = {
  github_copilot = github_copilot,
  local_llm = local_llm,
  disabled = {}
}

return ai_chat[os.getenv('NVIM_AI_CHAT_PROVIDER')] or ai_chat.disabled
