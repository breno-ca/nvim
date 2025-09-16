-- global capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- gopls
vim.lsp.config.gopls = {
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  cmd = { 'gopls' },
  root_markers = { 'go.work', 'go.mod' },
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = { nilness = true, unusedparams = true },
      completeUnimported = true,
      gofumpt = true,
      staticcheck = true,
      hints = {
        assignVariableTypes = true,
        parameterNames = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
      },
    },
  },
}
vim.lsp.enable('gopls')

-- phpactor
vim.lsp.config.phpactor = {
  filetypes = { 'php' },
  cmd = { 'phpactor', 'language-server' },
  root_markers = { '.phpactor.json', 'composer.json' },
  capabilities = capabilities,
  settings = {
    phpactor = {
      completion = { enabled = true },
      monorepo = { enabled = true },
      phpstan = { enabled = true },
      psalm = { enabled = true },
      xdebug = { enabled = true },
    },
  },
}
vim.lsp.enable('phpactor')

-- luals
vim.lsp.config.luals = {
  filetypes = { 'lua' },
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', 'init.lua' },
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { 'vim', 'nvim' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
    },
  },
}
vim.lsp.enable('luals')

-- pyright
vim.lsp.config.pyright = {
  filetypes = { 'python' },
  cmd = { 'pyright-langserver', '--stdio' },
  root_markers = { 'requirements.txt' },
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
      workspaceSymbols = {
        detectRelativeImports = true,
      },
    },
  },
}
vim.lsp.enable('pyright')

-- ts_ls (typescript/javascript)
vim.lsp.config.ts_ls = {
  filetypes = { 'javascript', 'typescript', 'typescriptreact' },
  cmd = { 'typescript-language-server', '--stdio' },
  root_markers = { 'package.json', 'tsconfig.json' },
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
}
vim.lsp.enable('ts_ls')

-- tailwindcss
vim.lsp.config.tailwindcss = {
  filetypes = { 'typescriptreact', 'javascriptreact' },
  cmd = { 'tailwindcss-language-server', '--stdio' },
  root_markers = { { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts' }, '.git' },
  capabilities = capabilities,
}
vim.lsp.enable('tailwindcss')

-- cssls
vim.lsp.config.cssls = {
  filetypes = { 'css', 'scss' },
  name = 'cssls',
  cmd = { 'vscode-css-language-server', '--stdio' },
  root_markers = { 'package.json', 'css.config.js', 'css.config.cjs', 'css.config.ts', '.git' },
  capabilities = capabilities,
}

-- jsonls
vim.lsp.config.jsonls = {
  filetypes = { 'json' },
  cmd = { 'vscode-json-language-server', '--stdio' },
  capabilities = capabilities,
}
vim.lsp.enable('jsonls')

-- bashls
vim.lsp.config.bashls = {
  filetypes = { 'sh', 'bash' },
  name = 'bashls',
  cmd = { 'bash-language-server', 'start' },
  root_markers = { '.git' },
  capabilities = capabilities,
  init_options = {
    format = {
      enable = true,
    },
  },
}
vim.lsp.enable('bashls')

-- sqls
vim.lsp.config.sqls = {
  filetypes = { 'sql' },
  name = 'sqls',
  cmd = { 'sqls' },
  root_markers = { '.git' },
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
}
vim.lsp.enable('sqls')

-- dockerls
vim.lsp.config.dockerls = {
  filetypes = { 'dockerfile' },
  name = 'dockerls',
  cmd = { 'docker-langserver', '--stdio' },
  root_markers = { 'Dockerfile', '.git' },
  capabilities = capabilities,
}
vim.lsp.enable('dockerls')

-- docker compose language service
vim.lsp.config.docker_compose_language_service = {
  filetypes = { 'yaml.docker-compose' },
  name = 'docker_compose_language_service',
  cmd = { 'docker-compose-langserver', '--stdio' },
  root_markers = { 'docker-compose.yml', 'docker-compose.yaml', '.git' },
  capabilities = capabilities,
}
vim.lsp.enable('docker_compose_language_service')

-- global format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    vim.lsp.buf.format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_user_command('LspRestart', function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd('edit')
end, { desc = 'Restart all LSP clients' })

vim.api.nvim_create_user_command('LspInfo', function()
  vim.cmd('checkhealth vim.lsp')
end, { desc = 'Show info about running LSPs' })

-- diagnostics
local config = vim.diagnostic.config
config({ virtual_text = { current_line = true } })

keymap(n, '<Leader>ve', call(function()
  if (not config().virtual_lines) then
    config({ virtual_lines = true, virtual_text = false }); return
  end
  config({ virtual_lines = false, virtual_text = { current_line = true } })
end), { desc = 'Toggle virtual lines/text diagnostics' })
