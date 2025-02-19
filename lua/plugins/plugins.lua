local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "master",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})

	local ensure_installed =
		{
			"python",
			"go",
			"bash",
			"c",
			"cpp",
			"css",
			"html",
			"javascript",
			"json",
			"julia",
			"lua",
			"markdown",
			"markdown_inline",
			"r",
			"regex",
			"rst",
			"rust",
			"toml",
			"tsx",
			"yaml",
			"vim",
			"vimdoc",
			"dockerfile",
		}, require("nvim-treesitter.configs").setup({
			ensure_installed = ensure_installed,
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
		})
end)
