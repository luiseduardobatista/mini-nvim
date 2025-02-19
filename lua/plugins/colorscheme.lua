local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({ source = "catppuccin/nvim", name = "catppuccin" })

require("catppuccin").setup({
	flavour = "mocha", 
	no_italic = true,  
	term_colors = true, 
	transparent_background = true, 
	styles = {
		comments = {}, 
		conditionals = {}, 
		loops = {}, 
		functions = {}, 
		keywords = {}, 
		strings = {}, 
		variables = {}, 
		numbers = {}, 
		booleans = {}, 
		properties = {}, 
		types = {}, 
	},
	color_overrides = {
		mocha = {
			base = "#000000", 
			mantle = "#000000", 
			crust = "#000000", 
		},
	},
	integrations = {
		telescope = {
			enabled = true, 
			style = "nvchad", 
		},
		dropbar = {
			enabled = true, 
			color_mode = true, 
		},
	},
})


vim.cmd.colorscheme("catppuccin")
