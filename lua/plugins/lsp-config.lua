local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

now_if_args(function()
  add({ source = "williamboman/mason-lspconfig.nvim", depends = { "williamboman/mason.nvim" } })
  add({ source = "neovim/nvim-lspconfig" })

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "basedpyright", "ruff" },
  })

  -- Set up global diagnostic configuration
  vim.diagnostic.config({ virtual_text = true })

  -- Create a single autocommand for LSP settings
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
      -- Set buffer-local omnifunc
      vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

      -- Define buffer-local keymaps
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
      end
      map("K", vim.lsp.buf.hover, "LSP Hover")
      map("<leader>cr", vim.lsp.buf.rename, "LSP Rename")
      map("<leader>ca", vim.lsp.buf.code_action, "LSP Code Action")
      map("<leader>co", function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
      end, "LSP Organize Imports")

      -- Disable hover for specific LSPs
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and (client.name == "ruff" or client.name == "basedpyright") then
        client.server_capabilities.hoverProvider = false
      end
    end,
    desc = "Setup LSP keymaps and settings on attach",
  })

  local lspconfig = require("lspconfig")
  local language_configs = {
    lua_ls = {},
    basedpyright = {
      settings = {
        basedpyright = {
          disableOrganizeImports = true,
        },
      },
    },
    ruff = {
      settings = {
        configurationPreference = "filesystemFirst",
        lineLength = 80,
        organizeImports = true,
      },
    },
  }

  -- Configure all LSPs
  for language, config in pairs(language_configs) do
    lspconfig[language].setup(config)
  end
end)