---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"dart",
		"lua",
		"javascript",
		"typescript",
		"tsx",
		"json",
		"html",
		"css",
		"scss",
		"yaml",
		"bash",
	},
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	indent = {
		enable = true,
    -- I have a couple of open issues for it though:
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues?q=RobertBrunhage+is%3Aopen
		disable = { "dart" },
	},
})

-- Remove this once https://github.com/nvim-treesitter/nvim-treesitter/issues/4945 is fixed
local parser = require("nvim-treesitter.parsers").get_parser_configs()
parser.dart = {
	install_info = {
		url = "https://github.com/UserNobody14/tree-sitter-dart",
		files = { "src/parser.c", "src/scanner.c" },
		revision = "8aa8ab977647da2d4dcfb8c4726341bee26fbce4", -- The last commit before the snail speed
	},
}
