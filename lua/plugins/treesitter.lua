-- Treesitter does quite a bit, read up on it!
-- The main branch only installs parsers and queries, highlight and indent are started below
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		ts.install({
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
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang then
					return
				end

				local function start()
					if not vim.api.nvim_buf_is_valid(args.buf) or not pcall(vim.treesitter.start, args.buf, lang) then
						return
					end
					-- Dart indent comes from dart-vim-plugin, treesitter's doesn't indent if/for blocks
					-- I have a couple of open issues for it though:
					-- https://github.com/nvim-treesitter/nvim-treesitter/issues?q=RobertBrunhage+is%3Aopen
					-- https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
					if lang ~= "dart" and vim.treesitter.query.get(lang, "indents") then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end

				-- auto_install: fetch parsers we don't have yet
				if vim.list_contains(ts.get_available(), lang) and not vim.list_contains(ts.get_installed(), lang) then
					ts.install(lang):await(start)
				else
					start()
				end
			end,
		})
	end,
}
