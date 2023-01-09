local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
    return
end

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
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
