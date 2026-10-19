return {
	-- Neovim development
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Language support, mainly for indentation because it's more stable than treesitter in Dart
	"dart-lang/dart-vim-plugin",

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = false,
			})
		end,
	},

	-- Git
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>")
			vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>")
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		config = function()
			-- default keybind is <leader>gy
			require("gitlinker").setup()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Color
	{
		"rose-pine/neovim",
		name = "rose-pine",

		config = function()
			-- Neovim sets 'background' from the terminal (Ghostty) and updates it when the
			-- terminal switches between light and dark, rose-pine then reloads the matching variant
			require("rose-pine").setup({
				dark_variant = "moon",
				light_variant = "dawn",
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
}
