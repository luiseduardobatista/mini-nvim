local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("n", "<Leader>" .. suffix, rhs, opts)
end

local C = function(cmd)
  return "<Cmd>" .. cmd .. "<CR>"
end

_G.minifiles_toggle = function(...)
  if not MiniFiles.close() then
    MiniFiles.open(...)
  end
end

require("mini.visits").setup()

-- ============================= Navigation (Splits) =============================
nmap_leader("h", "<C-w>h", "Move to left split")
nmap_leader("j", "<C-w>j", "Move to below split")
nmap_leader("k", "<C-w>k", "Move to above split")
nmap_leader("l", "<C-w>l", "Move to right split")

local lsp_picker = function(scope)
  return function()
    require("mini.extra").pickers.lsp({ scope = scope })
  end
end

map({ "n" }, "gD", lsp_picker("declaration"), "Goto declaration")
map({ "n" }, "gd", lsp_picker("definition"), "Goto definition")
map({ "n" }, "gi", lsp_picker("implementation"), "Goto implementation")
map({ "n" }, "gr", lsp_picker("references"), "Goto references")
map({ "n" }, "gy", lsp_picker("type_definition"), "Goto t[y]pe definition")

-- ============================= Quickfix =============================
nmap_leader("qo", C("copen"), "Quickfix List")
nmap_leader("qt", C("lua Config.toggle_quickfix()"), "Toggle Quickfix")
nmap_leader("qk", C("cprev"), "Previous Quickfix")
nmap_leader("qj", C("cnext"), "Next Quickfix")

-- ============================= File Management =============================
map("n", "-", C("lua _G.minifiles_toggle()"), "Toggle Explorer")
nmap_leader("fe", C("lua Config.bufdir()"), "Toggle Explorer (Buffer)")
nmap_leader("fg", C("Pick grep_live"), "Grep Live")

-- ============================= Fuzzy =============================
nmap_leader("<Space>", C("Pick files"), "Search files")
nmap_leader("fs", lsp_picker("workspace_symbol"), "Symbols workspace (LSP)")
nmap_leader("fS", lsp_picker("document_symbol"), "Symbols buffer (LSP)")
nmap_leader("fR", C('Pick visit_paths cwd=""'), "Visit paths (all)")
nmap_leader("fr", C("Pick oldfiles current_dir='true'"), "Recent files")

nmap_leader("fh", C("Pick help"), "Help Tags")

-- ============================= Buffer =============================
nmap_leader("bD", C("lua MiniBufremove.delete(0, true)"), "Delete all buffers")
nmap_leader("bd", C("lua MiniBufremove.delete()"), "Delete current buffer")

-- ============================= Code Editing =============================
nmap_leader("cf", C('lua require("conform").format({ lsp_fallback = true })'), "Format")
