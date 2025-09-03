-- global capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- root_pattern helper
local function root_pattern(...)
  local patterns = { ... }
  return function(fname)
    return vim.fs.dirname(vim.fs.find(patterns, { upward = true, path = fname })[1])
        or vim.fn.getcwd()
  end
end

-- gopls
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'gomod', 'gowork', 'gotmpl' },
  callback = function(args)
    vim.lsp.start({
      name = 'gopls',
      cmd = { 'gopls' },
      root_dir = root_pattern('go.work', 'go.mod', '.git')(args.file),
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
    })
  end,
})

-- phpactor
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'php' },
  callback = function(args)
    vim.lsp.start({
      name = 'phpactor',
      cmd = { 'phpactor', 'language-server' },
      root_dir = vim.fn.getcwd(),
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
    })
  end,
})

-- lua_ls
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function(args)
    vim.lsp.start({
      name = 'lua_ls',
      cmd = { 'lua-language-server' },
      root_dir = root_pattern('.git')(args.file),
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
    })
  end,
})

-- cssls
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'css', 'scss' },
  callback = function(args)
    vim.lsp.start({
      name = 'cssls',
      cmd = { 'vscode-css-language-server', '--stdio' },
      root_dir = root_pattern('.git')(args.file),
      capabilities = capabilities,
    })
  end,
})

-- tailwindcss
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'css', 'scss', 'html', 'javascript', 'typescript', 'typescriptreact' },
  callback = function(args)
    vim.lsp.start({
      name = 'tailwindcss',
      cmd = { 'tailwindcss-language-server', '--stdio' },
      root_dir = root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', '.git')(args.file),
      capabilities = capabilities,
    })
  end,
})

-- pyright
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python' },
  callback = function(args)
    vim.lsp.start({
      name = 'pyright',
      cmd = { 'pyright-langserver', '--stdio' },
      root_dir = root_pattern('requirements.txt', '.git')(args.file),
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
    })
  end,
})

-- ts_ls (typescript/javascript)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'typescriptreact' },
  callback = function(args)
    vim.lsp.start({
      name = 'ts_ls',
      cmd = { 'typescript-language-server', '--stdio' },
      root_dir = root_pattern('package.json', 'tsconfig.json', '.git')(args.file),
      capabilities = capabilities,
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
    })
  end,
})

-- bashls
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sh', 'bash' },
  callback = function(args)
    vim.lsp.start({
      name = 'bashls',
      cmd = { 'bash-language-server', 'start' },
      root_dir = root_pattern('.git')(args.file),
      capabilities = capabilities,
      init_options = {
        format = {
          enable = true,
        },
      },
    })
  end,
})

-- jsonls
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json' },
  callback = function(args)
    vim.lsp.start({
      name = 'jsonls',
      cmd = { 'vscode-json-language-server', '--stdio' },
      root_dir = root_pattern('.git')(args.file),
      capabilities = capabilities,
    })
  end,
})

-- sqls
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sql' },
  callback = function(args)
    vim.lsp.start({
      name = 'sqls',
      cmd = { 'sqls' },
      root_dir = root_pattern('.git')(args.file),
      capabilities = capabilities,
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
    })
  end,
})

-- dockerls
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dockerfile' },
  callback = function(args)
    vim.lsp.start({
      name = 'dockerls',
      cmd = { 'docker-langserver', '--stdio' },
      root_dir = root_pattern('.git')(args.file),
      capabilities = capabilities,
    })
  end,
})

-- docker compose language service
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'yaml.docker-compose' },
  callback = function(args)
    vim.lsp.start({
      name = 'docker_compose_language_service',
      cmd = { 'docker-compose-langserver', '--stdio' },
      root_dir = root_pattern('.git')(args.file),
      capabilities = capabilities,
    })
  end,
})

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
