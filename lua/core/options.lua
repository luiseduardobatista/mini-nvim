vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt
-- Configurações gerais
opt.undofile = true -- Habilita undo persistente
opt.undolevels = 10000
opt.backup = false -- Desabilita backup ao sobrescrever
opt.writebackup = false -- Desabilita backup de escrita
opt.mouse = "a" -- Habilita o mouse em todos os modos
opt.clipboard = "unnamedplus"
opt.updatetime = 200 -- Save swap file and trigger CursorHold



-- Ativa filetype, plugins e indentação
vim.cmd("filetype plugin indent on")

-- ============================================================================
-- Aparência
opt.breakindent = true -- Indenta linhas quebradas para alinhar com o início
opt.cursorline = true -- Destaca a linha atual
opt.linebreak = true -- Quebra linhas longas em pontos apropriados
opt.number = true -- Exibe números das linhas
opt.relativenumber = true
opt.splitbelow = true -- Splits horizontais abaixo
opt.splitright = true -- Splits verticais à direita
opt.ruler = false -- Não mostra posição do cursor na linha de comando
opt.showmode = false -- Não exibe o modo (ex: INSERT) na linha de comando
opt.wrap = false -- Não quebra linhas automaticamente
opt.signcolumn = "yes" -- Sempre mostra a coluna de sinais
opt.fillchars = "eob: " -- Remove os '~' fora do buffer
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.g.markdown_recommended_style = 0
opt.termguicolors = true -- True color support
opt.foldlevel = 99


-- ============================================================================
-- Edição e Busca
opt.ignorecase = true -- Busca sem diferenciar maiúsculas/minúsculas
opt.incsearch = true -- Mostra resultados da busca enquanto digita
opt.infercase = true -- Ajusta capitalização em autocompletar
opt.smartcase = true -- Se houver maiúsculas na busca, torna sensível
opt.smartindent = true -- Ativa indentação inteligente
vim.g.autofomart = true -- Autoformata
opt.completeopt = "menuone,noselect" -- Configura o menu de autocompletar
opt.virtualedit = "block" -- Permite mover o cursor livremente em blocos visuais
opt.formatoptions = "jcroqlnt" -- Ajusta formatação
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- ============================================================================
-- Configurações específicas para versões do Neovim
local o = vim.o
if vim.fn.has("nvim-0.9") == 1 then
	opt.shortmess:append("WcC") -- Reduz mensagens na linha de comando
	o.splitkeep = "screen" -- Minimiza scroll ao dividir janelas
else
	opt.shortmess:append("Wc")
end
