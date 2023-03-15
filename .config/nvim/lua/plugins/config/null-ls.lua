local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	return
end

require("mason-null-ls").setup({ automatic_setup = true })

local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		-- code_actions.refactoring, -- requires refactoring plugin
		formatting.gofmt,
		-- sources installed with mason are setup automatically
		code_actions.gitsigns,
	},
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						-- use null-ls as default formatter without asking
						--[[ filter = function(client)
							return client.name == "null-ls"
						end, ]]
					})
				end,
			})
		end
	end,
})

require("mason-null-ls").setup_handlers() -- If `automatic_setup` is true.
