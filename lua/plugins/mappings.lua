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

map({ "n" }, "-", C("lua MiniFiles.open()"), "Files")
map({ "n" }, "fg", C("Pick grep_live"), "Grep Live")

-- ============================= Fuzzy  =============================

nmap_leader("<Space>", C("Pick files"), "Search files")
-- map({ "n" }, L("gr"), C('Pick lsp scope="references"'), "References (LSP)")
nmap_leader("fs", C('Pick lsp scope="workspace_symbol"'), "Symbols workspace (LSP)")
nmap_leader("fS", C('Pick lsp scope="document_symbol"'), "Symbols buffer (LSP)")
nmap_leader("fR", C('Pick visit_paths cwd=""'), "Visit paths (all)")
nmap_leader("fr", C("Pick visit_paths"), "Visit paths (cwd)")

nmap_leader("fh", C("Pick help"), "Help Tags")

-- ============================= Buffer =============================
nmap_leader("bD", C("lua MiniBufremove.delete(0, true)"), "Delete all buffers")
nmap_leader("bd", C("lua MiniBufremove.delete()"), "Delete current buffer")

-- ============================= Code Editing =============================

nmap_leader("cf", C('lua require("conform").format({ lsp_fallback = true })'), "Format")
