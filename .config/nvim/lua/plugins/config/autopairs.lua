local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = { "string", "source" }, -- it will not add a pair on that treesitter node
    },
    disable_filetype = { "TelescopePrompt" },
    enable_check_bracket_line = false, -- don't add pair if matching closing on the same line
})

-- setup with cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
