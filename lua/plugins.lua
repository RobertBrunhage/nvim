return {
	-- Neovim development
	"folke/neodev.nvim",

	-- Language support, mainly for indentation because it's more stable than treesitter in Dart
	-- "dart-lang/dart-vim-plugin",

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
			require("rose-pine").setup({
				dark_variant = "moon",
				light_variant = "dawn",
			})

			local auto_dark_mode = require("auto-dark-mode")

			auto_dark_mode.setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.api.nvim_set_option("background", "dark")
					vim.api.nvim_command("colorscheme rose-pine")
				end,
				set_light_mode = function()
					vim.api.nvim_set_option("background", "light")
					vim.api.nvim_command("colorscheme rose-pine")
				end,
			})

			auto_dark_mode.init()
		end,

		dependencies = {
			"f-person/auto-dark-mode.nvim",
		},
	},

	-- Nice to have
	"github/copilot.vim",
}
