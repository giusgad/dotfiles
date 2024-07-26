return {
  { "williamboman/mason.nvim", cmd = "Mason", config = true },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end }, -- adapter for configuration
    },                                                                  -- lsp installer
    config = function()
      local handlers = require("plugins.lsp.handlers")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local opts = {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
          }
          --[[ if server_name == "rust-analyzer" then
						return
					end ]]
          -- options available for each server are found here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
          local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server_name)
          if require_ok then
            opts = vim.tbl_deep_extend("force", conf_opts, opts)
          end
          -- for server specific options see handlers.on_attach
          require("lspconfig")[server_name].setup(opts)
        end,
      })
    end,
  },
}
