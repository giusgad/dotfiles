local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = { "" }, -- A list of parser names, or "all"
    sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
    auto_install = false, -- set to false if tree-sitter cli not installed
    ignore_install = { "" }, -- List of parsers to ignore installing (for "all")

    autopairs = { enable = true },
    highlight = {
        enable = true, -- `false` will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "" } },
})
