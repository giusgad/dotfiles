local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

-- grep in specific files after two spaces
local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end
      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end
      return vim
        .iter({
          args,
          { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      prompt_title = "Live Grep++",
      finder = finder,
      debounce = 100,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ThePrimeagen/git-worktree.nvim",
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("git_worktree")
    end,
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>ff", builtin.find_files, desc = "telescope [F]ind [F]iles" },
        {
          "<leader>fF",
          function()
            builtin.find_files({ hidden = true, no_ignore = true })
          end,
          desc = "telescope [F]ind [F]iles",
        },
        { "<leader>fe", builtin.diagnostics, desc = "telescope diagnostics ([E]rrors)" },
        { "<leader>fm", builtin.marks, desc = "telescope [M]arks" },
        {
          "<leader>fE",
          function()
            builtin.diagnostics({ bufnr = 0 })
          end,
          desc = "telescope buffer diagnostics",
        },
        { "<leader>fg", live_multigrep, desc = "telescope [G]rep" },
        { "<leader>fG", builtin.git_status, desc = "telescope [G]it status" },
        {
          "<leader>fb",
          builtin.buffers,
          desc = "telescope [B]uffers",
        },
        {
          "<leader>fn",
          ":Telescope notify<CR>",
          desc = "telescope [N]otifications",
        },
        { "<leader>ft", ":TodoTelescope<CR>", desc = "telescope [T]ODOs" },
        {
          "<leader>fs",
          builtin.lsp_dynamic_workspace_symbols,
          desc = "telescope LSP [S]ymbols",
        },
        -- git
        {
          "<leader>gtl",
          require("telescope").extensions.git_worktree.git_worktrees,
          desc = "git work[T]ree [L]ist/switch",
        },
        {
          "<leader>gtn",
          require("telescope").extensions.git_worktree.create_git_worktree,
          desc = "git work[T]ree add/[N]ew",
        },
        {
          "<leader>gs",
          builtin.git_status,
          desc = "telescope [G]it [S]tatus",
        },
      }
    end,
  },
}
