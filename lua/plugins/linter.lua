local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({ source = "nvimtools/none-ls.nvim", depends = { "nvimtools/none-ls-extras.nvim" } })
  local null_ls = require("null-ls")
  null_ls.setup({
    null_ls.builtins.code_actions.textlint
  })
end)
