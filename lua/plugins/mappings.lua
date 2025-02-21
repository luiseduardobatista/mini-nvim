local map = function(mode, lhs, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(mode, lhs, rhs, opts)
end

local L = function(key)
	return "<leader>" .. key
end
local C = function(cmd)
	return "<Cmd>" .. cmd .. "<CR>"
end

map({ "n" }, "-", C("lua MiniFiles.open()"), "Files")
map({ "n" }, "fg", C('Pick grep_live'), "Grep Live")

-- ============================= Fuzzy  =============================

map({ "n" }, L("<Space>"), C("Pick files"), "Search files")
map({ "n" }, L("gr"), C('Pick lsp scope="references"'), "References (LSP)")
map({ "n" }, L("fs"), C('Pick lsp scope="workspace_symbol"'), "Symbols workspace (LSP)")
map({ "n" }, L("fS"), C('Pick lsp scope="document_symbol"'), "Symbols buffer (LSP)")
map({ "n" }, L("fv"), C('Pick visit_paths cwd=""'), "Visit paths (all)")
map({ "n" }, L("fr"), C("Pick visit_paths"), "Visit paths (cwd)")
map({ "n" }, L("fh"), C("Pick help"), "Help Tags")


-- ============================= Buffer =============================
map({ "n" }, L("bD"), C("lua MiniBufremove.delete(0, true)"), "Delete all buffers")
map({ "n" }, L("bd"), C("lua MiniBufremove.delete()"), "Delete current buffer")
