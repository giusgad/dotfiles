return function()
    vim.api.nvim_set_hl(0, "IblScope", { link = "GruvboxYellow" })
    require("ibl").setup({
        debounce = 100,
        scope = {
            show_start = false,
            show_end = false,
            include = {
                node_type = { rust = { "use_list", "field_initializer_list" }, lua = { "table_constructor" } },
            },
        },
    })
end
