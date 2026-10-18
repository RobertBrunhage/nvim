return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("mason").setup()
			-- Every server installed through mason is enabled (vim.lsp.enable) automatically
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- dart sdk ships with LSP
					"astro",
					"tailwindcss",
					"ts_ls",
					"lua_ls",
					-- AI inline completion, see below
					"copilot",
				},
			})

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "<leader>dl", vim.diagnostic.setqflist)

			vim.keymap.set({ "n", "i" }, "<C-b>", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buf = ev.buf }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				end,
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = false,
				-- [d / ]d are Neovim defaults, show the float on every jump
				jump = {
					on_jump = function(diagnostic, bufnr)
						if diagnostic then
							vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
						end
					end,
				},
			})

			local dartExcludedFolders = {
				vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
				vim.fn.expand("$HOME/.pub-cache"),
				vim.fn.expand("/opt/homebrew/"),
				vim.fn.expand("$HOME/tools/flutter/"),
			}

			-- cmd and filetypes come from nvim-lspconfig, when debugging the server set
			-- cmd = { "dart", "language-server", "--protocol=lsp", "--port=8123" }
			-- or add "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt"
			vim.lsp.config("dartls", {
				init_options = {
					onlyAnalyzeProjectsWithOpenFiles = false,
					suggestFromUnimportedLibraries = true,
					closingLabels = true,
					outline = false,
					flutterOutline = false,
				},
				settings = {
					dart = {
						analysisExcludedFolders = dartExcludedFolders,
						updateImportsOnRename = true,
						completeFunctionCalls = true,
						showTodos = true,
					},
				},
			})
			-- dart sdk ships the server (not mason), so mason-lspconfig won't enable it for us
			vim.lsp.enable("dartls")

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = {
								"vim",
								"require",
							},
						},
						-- Neovim runtime files are added by lazydev.nvim
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- AI inline completion (copilot language server from mason, sign in with :LspCopilotSignIn)
			vim.lsp.inline_completion.enable()

			vim.keymap.set("i", "<Tab>", function()
				if vim.lsp.inline_completion.get() then
					return ""
				end
				-- keep the default snippet jump
				if vim.snippet.active({ direction = 1 }) then
					return "<Cmd>lua vim.snippet.jump(1)<CR>"
				end
				return "<Tab>"
			end, { expr = true, desc = "Accept AI completion" })

			-- Turns off inline completion from every server, not only copilot
			local function toggle_ai()
				local enabled = not vim.lsp.inline_completion.is_enabled()
				vim.lsp.inline_completion.enable(enabled)
				vim.notify("AI completion " .. (enabled and "on" or "off"))
			end

			vim.api.nvim_create_user_command("AIToggle", toggle_ai, { desc = "Toggle AI completion" })
			vim.keymap.set("n", "<leader>cp", toggle_ai, { desc = "Toggle AI completion" })

			-- Show lsp progress (e.g. dart analysis) in the message area
			vim.api.nvim_create_autocmd("LspProgress", {
				group = vim.api.nvim_create_augroup("UserLspProgress", {}),
				callback = function(ev)
					local value = ev.data.params.value
					vim.api.nvim_echo({ { value.message or "done" } }, false, {
						id = "lsp." .. ev.data.params.token,
						kind = "progress",
						source = "vim.lsp",
						title = value.title,
						status = value.kind ~= "end" and "running" or "success",
						percent = value.percentage,
					})
				end,
			})

			-- Hot reload :)
			require("dart-tools")
		end,
		dependencies = {
			"mason-org/mason.nvim",
			-- bridges the gap between mason and lspconfig
			"mason-org/mason-lspconfig.nvim",
			-- loaded first so its completion capabilities reach every server
			"saghen/blink.cmp",
			-- support for dart hot reload on save
			"RobertBrunhage/dart-tools.nvim",
		},
	},
}
