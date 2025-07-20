local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
local on_attach = require 'lsp-format'.on_attach

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_dir = util.root_pattern('go.work', 'go.mod', '.git'),

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

lspconfig.phpactor.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	cmd = { 'phpactor', 'language-server' },
	filetypes = { 'php' },
	root_dir = util.root_pattern('index.php', 'server.php', 'composer.json', '.git'),

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

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_dir = util.root_pattern('.git'),

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
			format = { enable = true },
		},
	},
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	filetypes = { 'css', 'scss' },
})

lspconfig.tailwindcss.setup({})

lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_dir = util.root_pattern('requirements.txt', '.git'),

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

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	filetypes = { 'javascript', 'typescript', 'typescriptreact' },
})

lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	cmd = { 'bash-language-server', 'start' },
	filetypes = { 'sh', 'bash' },
	root_dir = util.root_pattern('.git'),

	init_options = {
		format = {
			enable = true,
		},
	},
})

lspconfig.jsonls.setup({})

lspconfig.sqls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.docker_compose_language_service.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- lspconfig.angularls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
