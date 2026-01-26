-- global capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.lsp.config.html = {
  capabilities = capabilities,
}
vim.lsp.enable('html')

vim.lsp.config.pyright = {
  capabilities = capabilities
}
vim.lsp.enable('pyright')

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

-----------------------------------------------------------
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

local config = vim.diagnostic.config
config({ virtual_text = { current_line = true } })

keymap(n, '<Leader>ve', call(function()
  if (not config().virtual_lines) then
    config({ virtual_lines = true, virtual_text = false }); return
  end
  config({ virtual_lines = false, virtual_text = { current_line = true } })
end), { desc = 'Toggle virtual lines/text diagnostics' })
