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

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
			false
		)
	end
end

-- for formatting on save
local lsp_formatting = function(bufnr)
	if vim.api.nvim_buf_get_option(bufnr, "filetype") == "markdown" then
		return
	end
	vim.lsp.buf.format({
		filter = function(client)
			return client.name ~= "tsserver" and client.name ~= "lua_ls"
		end,
		bufnr = bufnr,
		timeout_ms = 2000, -- needed for standardjs
	})
end
local formattingAugroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function lsp_keymaps(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>df", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	map("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>de", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.api.nvim_create_user_command("Format", function()
		lsp_formatting(bufnr)
	end, {})
end

local function on_attach(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = formattingAugroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = formattingAugroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

return {
	{
		"neovim/nvim-lspconfig", -- collection of configurations for built-in LSP client
		dependencies = {
			"williamboman/mason.nvim", -- external dependencies installer
			"williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with lspconfig
			{
				"simrat39/symbols-outline.nvim",
				config = function()
					require("symbols-outline").setup()
					vim.keymap.set("n", "<leader>do", [[:SymbolsOutline<CR>]])
				end,
			}, -- display symbols using LSP
			"folke/neodev.nvim", -- setup for init.lua and plugin development
			{ "j-hui/fidget.nvim", opts = {} }, -- UI for nvim-lsp progress
			"b0o/schemastore.nvim", -- SchemaStore catalog for use with jsonls and yamlls

			"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
		},
		lazy = false,
		config = function()
			require("neodev").setup({})
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
			local lspconfig = require("lspconfig")
			lspconfig.ansiblels.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.dockerls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.elmls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							-- get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- disable automatic detection and adaptation of third-party libraries
							checkThirdParty = false,
							-- make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
			lspconfig.purescriptls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			setup_diagnostics_layout()
			require("fidget").setup({})
			-- null-ls setup
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			null_ls.setup({
				debug = false,
				on_attach = on_attach,
				sources = {
					formatting.prettierd,
					-- formatting.standardjs,
					formatting.black,
					formatting.isort,
					formatting.stylua,
					formatting.elm_format,
					-- diagnostics.flake8,
				},
			})
			-- keymaps
			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "<leader>dii", "<cmd>LspInstallInfo<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>dig", "<cmd>LspInfo<CR>", opts)
		end,
	},
}
