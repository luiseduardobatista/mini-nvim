Config.toggle_quickfix = function()
  local cur_tabnr = vim.fn.tabpagenr()
  for _, wininfo in ipairs(vim.fn.getwininfo()) do
    if wininfo.quickfix == 1 and wininfo.tabnr == cur_tabnr then
      return vim.cmd("cclose")
    end
  end
  vim.cmd("copen")
end

Config.bufdir = function()
  local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
  MiniFiles.open(path, true)
end
