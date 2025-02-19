local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

local L = function (key) return "<leader>" .. key end
local C = function (cmd) return "<Cmd>" .. cmd .. "<CR>" end

map({"n"     }, "-", C"lua MiniFiles.open(vim.api.nvim_buf_get_name(0))", "File directory")
map({"n"     }, 'sg', C'lua require("mini.pick").builtin.grep_live()', 'Search grep (texto)')

-- Leader mappings ==========================================================

map({"n"     }, L'<Space>', C'lua require("mini.pick").builtin.files()', 'Search files')
