local M = {}

M.extend_hl = function(name, def)
  local current_def = vim.api.nvim_get_hl_by_name(name, true)
  local new_def = vim.tbl_extend("force", {}, current_def, def)
  vim.api.nvim_set_hl(0, name, new_def)
end

return M
