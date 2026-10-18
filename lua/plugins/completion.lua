return {
	"saghen/blink.cmp",
	-- release tags ship a prebuilt fuzzy matcher
	version = "1.*",
	dependencies = {
		-- snippets
		"rafamadriz/friendly-snippets",
	},
	opts = {
		-- Same keys as the old nvim-cmp preset.insert setup
		-- <Tab> is left out so it can accept AI completions (see lsp.lua)
		keymap = {
			preset = "none",
			["<C-y>"] = { "show", "fallback" },
			["<C-e>"] = { "cancel", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			-- arrows only move the selection, <C-n>/<C-p> also insert it
			["<Down>"] = {
				function(cmp)
					return cmp.select_next({ auto_insert = false })
				end,
				"fallback",
			},
			["<Up>"] = {
				function(cmp)
					return cmp.select_prev({ auto_insert = false })
				end,
				"fallback",
			},
			["<C-n>"] = { "select_next", "show", "fallback" },
			["<C-p>"] = { "select_prev", "show", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},
		completion = {
			-- Nothing is selected up front, so <CR> only confirms an item you picked
			list = { selection = { preselect = false } },
			documentation = { auto_show = true },
		},
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
		-- Keep the native command-line completion
		cmdline = { enabled = false },
	},
}
