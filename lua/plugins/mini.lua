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

