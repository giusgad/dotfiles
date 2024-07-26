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
    config = true,
    opts = {
      dir = "~/Documents/obsidian/vault/",
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
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = {
        "markdown",
      }
    end,
    ft = "markdown",
  },
  { "jbyuki/nabla.nvim", ft = "markdown" },
  -- TYPESCRIPT
  {
    "windwp/nvim-ts-autotag",
    config = true,
    ft = { "typescriptreact", "php" },
    main = "nvim-ts-autotag",
  },
  -- YUCK
  { "elkowar/yuck.vim", ft = "yuck", config = true },
  -- RUST
  {
    "saecki/crates.nvim",
    config = true,
    ft = "toml",
  },
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = require("plugins.lsp.handlers").on_attach,
          settings = {
            -- rust-analyzer language server configuratio
            ["rust-analyzer"] = require("plugins.lsp.settings.rust-analyzer"),
          },
        },
      }
    end,
  },
}
