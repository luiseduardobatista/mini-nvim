-- python.lua

-- Adiciona os plugins necessários para suporte a Python
local MiniDeps = require("mini.deps")
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({ source = "neovim/nvim-lspconfig" }) -- Para configuração do LSP
add({ source = "nvim-treesitter/nvim-treesitter" }) -- Para syntax highlighting
add({ source = "mfussenegger/nvim-dap" }) -- Para depuração
add({ source = "mfussenegger/nvim-dap-python" }) -- Extensão do DAP para Python
add({ source = "linux-cultist/venv-selector.nvim", depends = { "nvim-lua/plenary.nvim" }, checkout = "regexp" }) -- Para gerenciamento de ambientes virtuais
add({ source = "hrsh7th/nvim-cmp" }) -- Para autocompletion (opcional, se você usar cmp)
add({ source = "williamboman/mason.nvim" }) -- Para instalar LSPs e ferramentas
add({ source = "williamboman/mason-lspconfig.nvim", depends = { "williamboman/mason.nvim" } }) -- Integração do Mason com LSP

-- Inicializa o Mason
require("mason").setup()

-- Configura o Mason LSP Config
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "ruff" }, -- LSPs para Python
	automatic_installation = true, -- Instala automaticamente os LSPs configurados
})

-- Configuração do LSP para Python
local lspconfig = require("lspconfig")

-- Configuração do pyright
lspconfig.pyright.setup({
	on_attach = function(client, bufnr)
		-- Mapeamentos específicos para o LSP
		vim.keymap.set("n", "<leader>co", vim.lsp.buf.organize_imports, { buffer = bufnr, desc = "Organize Imports" })
	end,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
})

-- Configuração do ruff
lspconfig.ruff.setup({
	on_attach = function(client, bufnr)
		-- Desabilita hover do ruff para evitar conflitos com pyright
		client.server_capabilities.hoverProvider = false
	end,
	init_options = {
		settings = {
			logLevel = "error",
		},
	},
})

-- Configuração do Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = { "python", "ninja", "rst" }, -- Linguagens adicionais
	highlight = {
		enable = true,
	},
})

-- Configuração do DAP para Python
local dap = require("dap")

dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "python3" -- Ajuste o caminho do Python conforme necessário
		end,
	},
}

-- Configuração do Venv Selector
require("venv-selector").setup({
	settings = {
		options = {
			notify_user_on_venv_activation = true,
		},
	},
})

-- Mapeamentos de Teclas
local nmap_leader = function(suffix, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set("n", "<Leader>" .. suffix, rhs, opts)
end

-- LSP
nmap_leader("co", function()
	vim.lsp.buf.organize_imports()
end, "Organize Imports")

-- DAP
nmap_leader("dPt", function()
	require("dap-python").test_method()
end, "Debug Method")
nmap_leader("dPc", function()
	require("dap-python").test_class()
end, "Debug Class")

-- Venv Selector
nmap_leader("cv", "<cmd>VenvSelect<cr>", "Select VirtualEnv")
