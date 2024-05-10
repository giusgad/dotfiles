local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	return
end

local mason_null_ok = pcall(require, "mason-null-ls")
if mason_null_ok then
	require("mason-null-ls").setup()
end

local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		-- code_actions.refactoring, -- requires refactoring plugin
		formatting.gofmt,
		formatting.stylua,
		-- sources installed with mason are setup automatically
		formatting.prettierd,
	},
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = require("plugins.config.handlers").on_attach,
})
