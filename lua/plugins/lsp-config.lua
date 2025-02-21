local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

local function setup_lsp(language, config)
  local lspconfig = require("lspconfig")

  local function custom_on_attach(client, bufnr)
    vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    vim.diagnostic.config({ virtual_text = true })
  end

  lspconfig[language].setup({
    on_attach = custom_on_attach,
    settings = config.settings,
    init_options = config.init_options,
  })
end

now_if_args(function()
  add({ source = "williamboman/mason-lspconfig.nvim", depends = { "williamboman/mason.nvim" } })
  add({ source = "neovim/nvim-lspconfig" })

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "basedpyright", "ruff" },
  })

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

  -- Configurar todos os LSPs
  for language, config in pairs(language_configs) do
    setup_lsp(language, config)
  end

  -- Autocomando para desabilitar hover em LSPs específicos
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil or (client.name ~= "ruff" and client.name ~= "basedpyright") then
        return
      end
      if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
      end
    end,
    desc = "LSP: Disable hover capability from Ruff or BasedPyright",
  })
end)
