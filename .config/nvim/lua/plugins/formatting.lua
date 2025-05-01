local prettier = { "prettierd", "prettier", stop_after_first = true }
return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        -- lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = prettier,
        typescript = prettier,
        html = prettier,
        css = prettier,
        scss = prettier,
        less = prettier,
      },
    },
  },
}
