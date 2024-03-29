local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
        file_browser = {
            hijack_netrw = true,
            -- mappings = { ["i"] = { }, ["n"] = { }, },
        },
    },
})

telescope.load_extension("ui-select")
telescope.load_extension("git_worktree")
