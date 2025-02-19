-- Autocomandos baseados no mini.basics
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Criar um grupo de autocomandos para o mini.basics
local group = augroup("MiniBasicsAutocommands", {})

-- Destacar texto copiado por um curto período
autocmd("TextYankPost", {
	group = group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Destacar texto copiado",
})

-- Iniciar modo de inserção ao abrir um terminal integrado
autocmd("TermOpen", {
	group = group,
	pattern = "term://*",
	callback = function()
		if vim.api.nvim_get_current_buf() == vim.fn.bufnr("%") and vim.bo.buftype == "terminal" then
			vim.cmd("startinsert")
		end
	end,
	desc = "Entrar no modo de inserção ao abrir terminal",
})
