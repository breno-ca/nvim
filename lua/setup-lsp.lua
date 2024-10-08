local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'
local api = vim.api

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
	root_dir = util.root_pattern('index.php', 'server.php', 'composer.json', '.git'),

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
				globals = {
					'vim',
					'nvim',
				},
			},
			workspace = {
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
			format = {
				enable = true,
			},
		},
	},
})

lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	filetypes = { 'html', 'javascript' },
	root_dir = util.root_pattern('index.html', '.git'),
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	cmd = { 'css-languageserver', '--stdio' },
	filetypes = { 'css', 'javascript' },
})

lspconfig.quick_lint_js.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	filetypes = { 'javascript' },
})

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

lspconfig.yamlls.setup({})

lspconfig.sqls.setup({})

-- lspconfig.tsserver.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
--
-- 	cmd = { 'typescript-language-server', '--stdio' },
-- 	filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
-- 	root_dir = util.root_pattern('package.json', '.git'),
-- })


-- local namespace = api.nvim_create_namespace("flutter_tools_closing_labels")

-- lspconfig.dartls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
--
-- 	filetypes = { 'dart' },
-- 	root_dir = util.root_pattern('pubspec.yaml', '.git'),
--
-- 	init_options = {
-- 		onlyAnalyzeProjectsWithOpenFiles = true,
-- 		suggestFromUnimportedLibraries = true,
-- 		closingLabels = true,
-- 		outline = true,
-- 		flutterOutline = true,
-- 	},
-- 	settings = {
-- 		dart = {
-- 			completeFunctionCalls = true,
-- 			showTodos = true,
-- 			dartEnableSdkFormatter = true,
-- 			updateImportsOnRename = true,
-- 			enableSnippets = true,
-- 			documentation = true,
-- 		},
-- 		flutter = {
-- 			previewHotReloadOnSave = true,
-- 		},
-- 	},
-- 	handlers = {
-- 		-- other handlers...
-- 		['dart/textDocument/publishClosingLabels'] = function(err, response, _)
-- 			local api = vim.api
-- 			local namespace = api.nvim_create_namespace("flutter_tools_closing_labels")
-- 			local function render_labels(labels, opts)
-- 				api.nvim_buf_clear_namespace(0, namespace, 0, -1)
-- 				opts = opts or {}
-- 				local highlight = opts and opts.highlight or "Comment"
-- 				local prefix = opts and opts.prefix or "// "
--
-- 				for _, item in ipairs(labels) do
-- 					local line = tonumber(item.range["end"].line)
-- 					if line <= api.nvim_buf_line_count(0) then
-- 						api.nvim_buf_set_extmark(0, namespace, line, -1, {
-- 							virt_text = { {
-- 								prefix .. item.label,
-- 								highlight,
-- 							} },
-- 							virt_text_pos = "eol",
-- 							hl_mode = "combine",
-- 						})
-- 					end
-- 				end
-- 			end
--
-- 			local opts = { enabled = true, highlight = "Comment", prefix = "// " } -- substitua por suas configurações
-- 			if err or not opts.enabled then return end
-- 			local uri = response.uri
-- 			if uri ~= vim.uri_from_bufnr(0) then return end
-- 			render_labels(response.labels, opts)
-- 		end,
-- 		-- other handlers...
-- 	},
--
-- })


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
