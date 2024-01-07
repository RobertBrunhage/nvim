local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- LSP
	"neovim/nvim-lspconfig",

	-- Simpler installation of LSP servers
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Autocompletion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lua",

	-- Snippets engine
	"L3MON4D3/LuaSnip",

	-- snippets
	"rafamadriz/friendly-snippets",

	-- Neovim development
	"folke/neodev.nvim",

	"mhartington/formatter.nvim",

	-- File and folder management
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
	},
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-fzy-native.nvim",
	"nvim-telescope/telescope-live-grep-args.nvim",

	-- Allows using telescope for things like code action (handy for searching)
	"nvim-telescope/telescope-ui-select.nvim",

	-- Enables you to go back in your local history
	{
		"jiaoshijie/undotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Language support, mainly for indentation because it's more stable than treesitter
	"dart-lang/dart-vim-plugin",

	-- support for dart hot reload on save
	"RobertBrunhage/dart-tools.nvim",

	-- Treesitter does quite a bit, read up on it!
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",

	-- Git
	"tpope/vim-fugitive",
	"ruifm/gitlinker.nvim",

	-- UI
	"f-person/auto-dark-mode.nvim",
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},

	-- Nice to have
	"numToStr/Comment.nvim",
	"github/copilot.vim",
	{ "j-hui/fidget.nvim", tag = "legacy" },
}

require("lazy").setup(plugins, {})
