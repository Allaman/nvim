local nvim_lsp = require("lspconfig")

-- detect python venv
-- https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-851247107
local util = require("lspconfig/util")
local path = util.path
local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end
	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			return path.join(path.dirname(match), "bin", "python")
		end
	end
	-- Fallback to system Python.
	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {
	"bashls",
	"dockerls",
	"gopls",
	"jsonls",
	"pyright",
	"sumneko_lua",
	"terraformls",
	"texlab",
	"tsserver",
	"yamlls",
}
-- Use a loop to conveniently call 'setup' on multiple servers
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = function(client, bufnr)
			-- disable formatting for LSP clients as this is handled by null-ls
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
			-- enable illuminate to intelligently highlight
			require("illuminate").on_attach(client)
			-- enable navic for displaying current code context
			require("nvim-navic").attach(client, bufnr)
			-- add LSP specific key mappings to which key
			local wk = require("which-key")
			local default_options = { silent = true }
			wk.register({
				l = {
					name = "LSP",
					A = {
						"<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
						"Add Workspace Folder",
					},
					D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration" },
					I = {
						"<cmd>lua vim.lsp.buf.implementation()<cr>",
						"Show implementations",
					},
					L = {
						"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
						"List Workspace Folders",
					},
					R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
					S = {
						"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
						"Workspace Symbols",
					},
					W = {
						"<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
						"Remove Workspace Folder",
					},
					a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
					d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go To Definition" },
					e = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
					f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
					i = { "<cmd>LspInfo<cr>", "Connected Language Servers" },
					k = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Commands" },
					l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line diagnostics" },
					n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
					p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
					q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
					r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
					s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
					t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
					w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
				},
			}, { prefix = "<leader>", mode = "n", default_options })
		end,
		before_init = function(_, config)
			if lsp == "pyright" then
				config.settings.python.pythonPath = get_python_path(config.root_dir)
			end
		end,
		capabilities = capabilities,
		settings = {
			json = {
				format = { enabled = false },
				schemas = {
					{
						description = "ESLint config",
						fileMatch = { ".eslintrc.json", ".eslintrc" },
						url = "http://json.schemastore.org/eslintrc",
					},
					{
						description = "Package config",
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package",
					},
					{
						description = "Packer config",
						fileMatch = { "packer.json" },
						url = "https://json.schemastore.org/packer",
					},
					{
						description = "Renovate config",
						fileMatch = {
							"renovate.json",
							"renovate.json5",
							".github/renovate.json",
							".github/renovate.json5",
							".renovaterc",
							".renovaterc.json",
						},
						url = "https://docs.renovatebot.com/renovate-schema",
					},
					{
						description = "OpenApi config",
						fileMatch = { "*api*.json" },
						url = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json",
					},
				},
			},
			Lua = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				runtime = {
					version = "LuaJIT",
				},
				completion = { enable = true, callSnippet = "Both" },
				diagnostics = {
					enable = true,
					globals = { "vim", "describe" },
				},
				workspace = {
					library = {
						vim.api.nvim_get_runtime_file("", true),
					},
					-- adjust these two values if your performance is not optimal
					maxPreload = 2000,
					preloadFileSize = 1000,
				},
				telemetry = { enable = false },
			},
			redhat = { telemetry = { enabled = false } },
			texlab = {
				auxDirectory = ".",
				bibtexFormatter = "texlab",
				build = {
					args = {
						"--keep-intermediates",
						"--keep-logs",
						"--synctex",
						"%f",
					},
					executable = "tectonic",
					forwardSearchAfter = false,
					onSave = false,
				},
				chktex = { onEdit = false, onOpenAndSave = false },
				diagnosticsDelay = 300,
				formatterLineLength = 80,
				forwardSearch = { args = {} },
				latexFormatter = "latexindent",
				latexindent = { modifyLineBreaks = false },
			},
			yaml = {
				schemaStore = {
					enable = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
				schemas = {
					kubernetes = "*.yaml",
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
					["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
					["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
					["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
					["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
					["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
					["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
					["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
					["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
				},
				format = { enabled = false },
				validate = false, -- TODO: conflicts between Kubernetes resources and kustomization.yaml
				completion = true,
				hover = true,
			},
		},
		flags = { debounce_text_changes = 150 },
	})
end
