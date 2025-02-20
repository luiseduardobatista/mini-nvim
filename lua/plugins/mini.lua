require("mini.ai").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.clue").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.files").setup({ windows = { preview = true } })
require("mini.move").setup()
require("mini.completion").setup()
require("mini.misc").setup()
require("mini.extra").setup()
require("mini.comment").setup()

local win_config = function()
    local height = math.floor(0.618 * vim.o.lines)
    local width = math.floor(0.618 * vim.o.columns)
    return {
      anchor = 'NW', height = height, width = width,
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


