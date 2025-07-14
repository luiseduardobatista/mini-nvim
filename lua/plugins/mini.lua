local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later


now(function()
  require("mini.statusline").setup()
end)
now_if_args(function()
  require("mini.visits").setup()
end)
now(function()
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()
  later(MiniIcons.tweak_lsp_kind())
end)
now_if_args(function()
  require("mini.files").setup({ windows = { preview = true } })
end)
now_if_args(function()
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
  vim.ui.select = MiniPick.ui_select
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

now(function()
  require("mini.completion").setup({
    lsp_completion = {
      source_func = "omnifunc",
      auto_setup = false,
    },
    window = {
      info = { border = 'double' },
      signature = { border = 'double' },
    },
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
