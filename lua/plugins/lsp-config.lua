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

		-- Exibe mensagens inline ao invés de popups
		vim.diagnostic.config({ virtual_text = true })
	end

	lspconfig.lua_ls.setup({
		on_attach = custom_on_attach,
	})
	lspconfig.basedpyright.setup({
		on_attach = custom_on_attach,
    settings = { basedpyright =  {
      disableOrganizeImports = true,
    },
  },
  python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
	})
  lspconfig.ruff.setup(
    { on_attach = custom_on_attach }
  )

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil or (client.name ~= 'ruff' and client.name ~= 'basedpyright') then
      return
    end
    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff or BasedPyright',
})
end)

