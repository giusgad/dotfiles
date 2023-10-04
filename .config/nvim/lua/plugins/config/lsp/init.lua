local mason_ok = pcall(require, "mason")
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
local mason_dap_ok = pcall(require, "mason-nvim-dap")

if mason_ok then
    require("mason").setup()
end
if mason_lspconfig_ok then
    mason_lspconfig.setup()
end
if mason_dap_ok then
    require("mason-nvim-dap").setup({ automatic_setup = true })
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

local handlers = require("plugins.config.handlers")
handlers.setup()

-- AUTOMATIC SERVER SETUP
mason_lspconfig.setup_handlers({
    function(server_name)
        local opts = {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
        }
        if server_name == "rust_analyzer" or server_name == "jdtls" then
            return
        end
        -- options available for each server are found here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        local require_ok, conf_opts = pcall(require, "plugins.config.lsp.settings." .. server_name)
        if require_ok then
            opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end
        -- for server specific options see handlers.on_attach
        lspconfig[server_name].setup(opts)
    end,
})
