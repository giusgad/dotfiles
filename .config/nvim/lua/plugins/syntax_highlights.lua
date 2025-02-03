local function disable_plugin(_, bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 2000
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufRead" },
    config = function(_, opts)
      vim.treesitter.language.register("wgsl_bevy", "wgsl")
      vim.api.nvim_set_hl(0, "rainbowcol1", { ctermfg = "White" })
      local configs = require("nvim-treesitter.configs")
      configs.setup(opts)
    end,
    opts = {
      ensure_installed = { "markdown", "markdown_inline", "vim", "vimdoc", "lua" },
      sync_install = false,
      auto_install = true, -- set to false if tree-sitter cli not installed
      autopairs = { enable = true },
      highlight = {
        enable = true, -- `false` will disable the whole extension
        disable = disable_plugin,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true, disable = disable_plugin },
      rainbow = {
        enable = true,
        disable = disable_plugin,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true,                                          -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil,                                          -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        termcolors = { "Yellow", "Green", "Cyan", "Magenta", "Blue" }, -- table of colour name strings
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
        },
      },
      matchup = {
        enable = true,
      },
    },
  },
  { "nvim-treesitter/playground", event = "VeryLazy" },
  {
    "RRethy/vim-illuminate",
    opts = {
      min_count_to_highlight = 2,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3c3836" })
      -- from LazyVim's config
      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end
      map("]]", "next")
      map("[[", "prev")
      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
    event = "BufRead",
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      vim.g.rainbow_delimiters = {
        highlight = {
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    main = "colorizer",
    opts = { user_default_options = { mode = "virtualtext" } },
    ft = { "css", "scss" },
  },
}
