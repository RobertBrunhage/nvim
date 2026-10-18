-- Formatting goes through the language server unless a formatter is listed here,
-- so dart, go, rust, ... need nothing. Formatters listed here are installed by mason.
local formatters_by_ft = {
	lua = { "stylua" },
	-- dart = { "dcm_format", "dart_format", stop_after_first = true },
}
for _, ft in ipairs({
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"json",
	"css",
	"html",
	"graphql",
}) do
	formatters_by_ft[ft] = { "prettierd" }
end

return {
	"stevearc/conform.nvim",
	dependencies = { "mason-org/mason.nvim" },
	config = function()
		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
		})

		-- scheduled so mason is set up (lsp.lua) before installing
		vim.schedule(function()
			local registry = require("mason-registry")
			registry.refresh(function()
				for _, formatters in pairs(formatters_by_ft) do
					for _, name in ipairs(formatters) do
						-- the same formatter is listed for several filetypes, only install it once
						if registry.has_package(name) then
							local package = registry.get_package(name)
							if not package:is_installed() and not package:is_installing() then
								package:install()
							end
						end
					end
				end
			end)
		end)
	end,
}
