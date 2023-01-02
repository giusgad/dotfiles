require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({ automatic_setup = true })

local lspconfig = require("lspconfig")
local handlers = require("plugins.config.handlers")
handlers.setup()

-- AUTOMATIC SERVER SETUP
require("mason-lspconfig").setup_handlers({
	function(server_name)
		local opts = {
			on_attach = handlers.on_attach,
			capabilities = handlers.capabilities,
		}
		-- options available for each server are found here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		local require_ok, conf_opts = pcall(require, "plugins.config.lsp.settings." .. server_name)
		if require_ok then
			opts = vim.tbl_deep_extend("force", conf_opts, opts)
		end
		-- for server specific options see handlers.on_attach
		lspconfig[server_name].setup(opts)
	end,
})
