local lspconfig = require'lspconfig'
local util = require'lspconfig/util'

local capabilities = require'cmp_nvim_lsp'.default_capabilities()
local on_attach = require'lsp-format'.on_attach

lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_dir = util.root_pattern('go.work', 'go.mod', '.git'),

	settings = {
		gopls = {
			analyses = {
				nilness = true,
				unusedparams = true,
			},
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

lspconfig.phpactor.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	cmd = { 'phpactor', 'language-server' },
	filetypes = { 'php' },
	root_dir = util.root_pattern('index.php', 'composer.json', '.git'),

	settings = {
		phpactor = {
			completion = {
				enabled = true,
			},
			monorepo = {
				enabled = true,
			},
			phpstan = {
				enabled = true,
			},
			psalm = {
				enabled = true,
			},
			xdebug = {
				enabled = true,
			},
		},
	},
})

lspconfig.lua_ls.setup({})

lspconfig.bashls.setup({})

lspconfig.jsonls.setup({})

lspconfig.yamlls.setup({})



--[[
Configuração de LSPs (Language Server Protocols)

Cada linguagem a ser utilizada deve conter uma
chamada setup() para funcionar contendo ou não
uma table de configurações. 

Para listar os LSPs disponíveis execute :Mason.

Para instalar um LSP da lista basta escrever
:MasonInstall informando o nome do LSP desejado

A lista de compatibilidade e configurações se
encontra em:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
--]]
