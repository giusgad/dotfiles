return {
  { "williamboman/mason.nvim", cmd = "Mason", config = true },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = true }, -- adapter for configuration
    }, -- lsp installer
    config = function()
      local handlers = require("plugins.lsp.handlers")
      handlers.setup()
    end,
  },
}
