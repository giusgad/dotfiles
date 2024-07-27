local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    -- vim.diagnostic.config({ signs = { [sign.name] = {} } })
  end

  local config = {
    -- virtual_text = true, -- text at the end of the line
    virtual_text = {
      prefix = "",
    },
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
  }

  vim.diagnostic.config(config)
end

M.on_attach = function(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
end

return M
