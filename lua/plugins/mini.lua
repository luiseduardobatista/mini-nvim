local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function() require("mini.ai").setup() end)
later(function() require("mini.surround").setup() end)
later(function() require("mini.pairs").setup() end)
require("mini.clue").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.files").setup({ windows = { preview = true } })
later(function() require("mini.move").setup() end)
require("mini.completion").setup({ lsp_completion = {
	source_func = "omnifunc",
} })
require("mini.misc").setup()
require("mini.extra").setup()
later(function() require("mini.comment").setup() end)
require("mini.visits").setup()
require("mini.bufremove").setup()
require("mini.hipatterns").setup()


later(function()
	local hipatterns = require("mini.hipatterns")
	local hi_words = MiniExtra.gen_highlighter.words
	hipatterns.setup({
		highlighters = {
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

local win_config = function()
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

require("mini.pick").setup({
	mappings = {
		choose_in_vsplit = "<C-CR>",
	},
	options = {
		use_cache = true,
	},
	window = {
		config = win_config,
	},
})

vim.ui.select = function(items, opts, on_choice)
	local start_opts = { window = { config = { width = vim.o.columns } } }
	return MiniPick.ui_select(items, opts, on_choice, start_opts)
end
