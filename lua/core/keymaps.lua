local keymap = vim.keymap.set

-- Limpa a busca com esc
keymap("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear Search" })

-- Movimentação com j/k respeitando linhas visíveis (útil para linhas quebradas)
keymap({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], { expr = true, desc = "Move down respecting line wrapping" })
keymap({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], { expr = true, desc = "Move up respecting line wrapping" })

-- Inserir linhas vazias acima/abaixo sem entrar no modo de inserção
keymap("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Insert empty line above" })
keymap("n", "go", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "Insert empty line below" })

-- Copiar/colar com o clipboard do sistema
keymap({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
keymap("n", "gp", '"+p', { desc = "Paste from system clipboard" })
keymap("x", "gp", '"+P', { desc = "Paste from system clipboard" })

-- Selecionar último texto alterado ou copiado
keymap(
	"n",
	"gV",
	'"`[" . strpart(getregtype(), 0, 1) . "`]"',
	{ expr = true, replace_keycodes = false, desc = "Select last changed text" }
)

-- Busca dentro da seleção visual
keymap("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Salvar arquivo com Ctrl+S
keymap("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save file" })
keymap({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and exit insert mode" })

-- Alternar configurações comuns com prefixo `\`
keymap("n", "\\w", "<Cmd>setlocal wrap! wrap?<CR>", { desc = "Toggle line wrapping" })
keymap("n", "\\n", "<Cmd>setlocal number! number?<CR>", { desc = "Toggle line numbers" })
keymap("n", "\\r", "<Cmd>setlocal relativenumber! relativenumber?<CR>", { desc = "Toggle relative numbering" })
keymap("n", "\\h", "<Cmd>let v:hlsearch = 1 - v:hlsearch<CR>", { desc = "Toggle search highlight" })
keymap("n", "\\c", "<Cmd>setlocal cursorline! cursorline?<CR>", { desc = "Toggle cursor line highlight" })
keymap("n", "\\s", "<Cmd>setlocal spell! spell?<CR>", { desc = "Toggle spell checker" })
