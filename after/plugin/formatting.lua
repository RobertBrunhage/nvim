local settings = {
	lua = {
		require("formatter.filetypes.lua").stylua,
	},
	typescriptreact = {
		require("formatter.filetypes.typescript").prettier,
	},
	typescript = {
		require("formatter.filetypes.typescript").prettier,
	},
	dart = {
		require("formatter.filetypes.dart").dartformat,
	},
	graphql = {
		require("formatter.filetypes.graphql").prettier,
	},
	["*"] = {
		-- "formatter.filetypes.any" defines default configurations for any
		-- filetype
		require("formatter.filetypes.any").remove_trailing_whitespace,
	},
}

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = settings,
})

vim.keymap.set("n", "<leader>f", function()
	if settings[vim.bo.filetype] ~= nil then
		vim.cmd([[Format]])
	else
		vim.lsp.buf.format()
	end
end)
