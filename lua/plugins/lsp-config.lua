local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

now_if_args(function()
  add({ source = "williamboman/mason-lspconfig.nvim", depends = { "williamboman/mason.nvim" } })
  add({ source = "neovim/nvim-lspconfig" })

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "basedpyright", "ruff" },
  })

  local lspconfig = require("lspconfig")

  lspconfig.lua_ls.setup({})
  lspconfig.basedpyright.setup({})
  lspconfig.ruff.setup({})

  -- Usando LspAttach para definir keymaps e comportamento apenas quando um LSP estiver ativo
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local opts = { buffer = event.buf }

      -- Keymaps do LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

      -- Exibe mensagens inline ao invés de popups
      vim.diagnostic.config({ virtual_text = true })
    end,
  })
end)
