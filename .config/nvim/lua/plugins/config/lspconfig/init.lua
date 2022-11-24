local lspconfig = require("lspconfig")

-- Completions variable
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pyright.setup{
    capabilities = capabilities
}
lspconfig.gopls.setup{
    capabilities = capabilities
}
lspconfig.sumneko_lua.setup{
    capabilities = capabilities
}
