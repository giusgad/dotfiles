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
        { "<leader>mv", nabla.toggle_virt, desc = "Show [Math] [V]irtual lines" },
      }
    end,
  },
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
