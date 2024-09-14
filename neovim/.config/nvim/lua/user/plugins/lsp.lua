local function setup_diagnostics_layout()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

-- for highlighting references of the word under the cursor
local function lsp_highlight_document(client, bufnr)
	if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		local highlight_augroup = vim.api.nvim_create_augroup("loz-lsp-highlight", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = bufnr,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("loz-lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "loz-lsp-highlight", buffer = event2.buf })
			end,
		})
	end
end

local function lsp_keymaps(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

	local opts = { noremap = true, silent = true }
	local map = vim.keymap.set
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ds", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>drn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

	map("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>de", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		vim.keymap.set("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
		end, { buffer = bufnr, desc = "LSP: [T]oggle Inlay [H]ints" })
	end
end

local function on_attach(client, bufnr)
	lsp_keymaps(client, bufnr)
	lsp_highlight_document(client, bufnr)
end

return {
	{
		"folke/lazydev.nvim", -- LuaLS setup for Neovim
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{
		"neovim/nvim-lspconfig", -- collection of configurations for built-in LSP client
		dependencies = {
			"williamboman/mason.nvim", -- external dependencies installer
			"williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with lspconfig
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- installs third-party tools
			{
				"simrat39/symbols-outline.nvim",
				config = function()
					require("symbols-outline").setup()
					vim.keymap.set("n", "<leader>do", [[:SymbolsOutline<CR>]])
				end,
			}, -- display symbols using LSP
			{ "j-hui/fidget.nvim", opts = {} }, -- UI for nvim-lsp progress
			"b0o/schemastore.nvim", -- SchemaStore catalog for use with jsonls and yamlls
		},
		lazy = false,
		config = function()
			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if status_ok then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ansiblels",
					"docker_compose_language_service",
					"dockerls",
					"elmls",
					"gopls",
					"lua_ls",
					"purescriptls",
					"pyright",
					"rust_analyzer",
					"terraformls",
					"tsserver",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"ansible-lint",
					"bashls",
					"black",
					"clangd",
					"elm-format",
					"isort",
					"jsonls",
					"prettierd",
					"regols",
					"shellcheck",
					"shfmt",
					"standardjs",
					"stylua",
					"yamlls",
				},
			})
			-- this only needs to contain servers with extra config, capabilities and
			-- on_attach will be added to all installed servers below
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							-- do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
						},
					},
				},
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
						},
					},
				},
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								-- You must disable built-in schemaStore support if you want to use
								-- this plugin and its advanced options like `ignore`.
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
			}
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						server.on_attach = on_attach
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
			setup_diagnostics_layout()
			require("fidget").setup({})
			-- keymaps
			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "<leader>dii", "<cmd>LspInstallInfo<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>dig", "<cmd>LspInfo<CR>", opts)
		end,
	},
}
