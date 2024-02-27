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

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

local rustfmt = h.make_builtin({
	name = "rustfmt",
	meta = {
		url = "https://github.com/rust-lang/rustfmt",
		description = "A tool for formatting rust code according to style guidelines.",
		notes = {
			"`--edition` defaults to `2015`. To set a different edition, use `extra_args`.",
			"See [the wiki](https://github.com/nvimtools/none-ls.nvim/wiki/Source-specific-Configuration#rustfmt) for other workarounds.",
		},
	},
	method = FORMATTING,
	filetypes = { "rust" },
	generator_opts = {
		command = "rustfmt",
		args = { "--emit=stdout" },
		to_stdin = true,
	},
	factory = h.formatter_factory,
})

null_ls.setup({
	debug = false,
	sources = {
		-- code_actions.refactoring, -- requires refactoring plugin
		formatting.gofmt,
		formatting.stylua,
		-- sources installed with mason are setup automatically
		rustfmt,
		formatting.prettierd.with({ extra_args = { "--no-semi" } }),
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
						-- filter = function(client)
						-- 	return client.name == "null-ls"
						-- end,
					})
				end,
			})
		end
	end,
})
