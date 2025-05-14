return {
  -- LUA
  {
    "folke/neodev.nvim",
    config = true,
    opts = {
      override = function(_, options)
        options.library.enabled = true
      end,
    },
    ft = "lua",
  },
  -- MARKDOWN/LATEX
  {
    "epwalsh/obsidian.nvim",
    opts = {
      dir = "~/Nextcloud/documents/vault",
      completion = { nvim_cmp = true },
      disable_frontmatter = true,
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = {
            noremap = false,
            expr = true,
            buffer = true,
          },
        },
      },
    },
    ft = "markdown",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = {
        "markdown",
      }
      vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/lua/markdown.css")
    end,
  },
  {
    "jbyuki/nabla.nvim",
    ft = "markdown",
    keys = function()
      local nabla = require("nabla")
      return {
        { "<leader>mp", nabla.popup, desc = "Show [M]ath preview [P]opup" },
        {
          "<leader>mv",
          function() -- preserve wrap (workaround for nabla bug)
            local wrap = vim.o.wrap
            nabla.toggle_virt()
            vim.o.wrap = wrap
          end,
          desc = "Show [Math] [V]irtual lines",
        },
      }
    end,
  },
  -- TYPESCRIPT
  {
    "windwp/nvim-ts-autotag",
    config = true,
    ft = { "typescriptreact", "php", "html" },
    main = "nvim-ts-autotag",
  },
  -- YUCK
  { "elkowar/yuck.vim", ft = "yuck", config = true },
  -- RUST
  {
    "saecki/crates.nvim",
    config = true,
    ft = { "toml", "rust" },
    keys = function()
      local crates = require("crates")
      return {
        { "<leader>cf", crates.show_features_popup, desc = "[C]rates show [F]eatures" },
        { "<leader>cd", crates.open_documentation, desc = "[C]rates open [D]ocs" },
        { "<leader>cr", crates.reload, desc = "[C]rates [R]eload" },
        { "<leader>cg", crates.open_repository, desc = "[C]rates open [G]it repo" },
      }
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          settings = {},
        },
      }
    end,
    event = "VeryLazy",
    keys = function()
      return {
        -- stylua: ignore start
        { "<leader>rr", function() vim.cmd.RustLsp("run") end,         desc = "[R]un current target" },
        { "<leader>rR", function() vim.cmd.RustLsp("runnables") end,   desc = "Select and [R]un target" },
        { "<leader>rd", function() vim.cmd.RustLsp("debug") end,       desc = "[D]ebug current target" },
        { "<leader>rD", function() vim.cmd.RustLsp("debuggables") end, desc = "Select and [D]ebug target" },
        -- stylua: ignore end
      }
    end,
  },
}
