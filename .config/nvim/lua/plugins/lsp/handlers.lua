local M = {}

M.setup = function()
  local config = {
    -- virtual_text = true, -- text at the end of the line
    virtual_text = {
      prefix = "",
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
  }

  vim.diagnostic.config(config)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
end

return M
