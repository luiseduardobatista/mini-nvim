local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	require("mini.statusline").setup()
end)
now(function()
	require("mini.visits").setup()
end)
now(function()
	require("mini.icons").setup()
end)
now(function()
	require("mini.files").setup({ windows = { preview = true } })
end)
now(function()
	local function win_config()
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
		options = { use_cache = true },
		window = { config = win_config },
		mappings = {
			choose_in_vsplit = "<C-CR>",
			sys_paste = {
				char = "<C-v>",
				func = function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-r>+", true, true, true), "n", true)
				end,
			},
		},
	})
end)

later(function()
	require("mini.ai").setup()
end)
later(function()
	require("mini.surround").setup()
end)
later(function()
	require("mini.pairs").setup()
end)
later(function()
	require("mini.move").setup()
end)
later(function()
	require("mini.comment").setup()
end)
later(function()
	require("mini.clue").setup()
end)
later(function()
	require("mini.bufremove").setup()
end)
later(function()
	require("mini.extra").setup()
end)

later(function()
	require("mini.completion").setup({
		lsp_completion = { source_func = "omnifunc" },
	})
end)

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

now(function()
	vim.ui.select = function(items, opts, on_choice)
		local start_opts = { window = { config = { width = vim.o.columns } } }
		return MiniPick.ui_select(items, opts, on_choice, start_opts)
	end
end)
