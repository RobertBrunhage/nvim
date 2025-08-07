return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				["javascript|typescript|javascriptreact|typescriptreact|json|css|html|graphql"] = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				cpp = { "clang-format", lsp_format = "fallback" },
				-- dart = { "dcm_format", "dart_format", stop_after_first = true },
				dart = { --[[ "dart_format", ]] lsp_format = "fallback" },
				python = { "black" },
			},
		})
	end,
}
