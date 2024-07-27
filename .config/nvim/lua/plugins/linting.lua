return {
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
  }, -- null-ls to mason integration
  {
    "nvimtools/none-ls.nvim",
    opts = function()
      local formatting = require("null-ls").builtins.formatting
      return {
        debug = false,
        sources = {
          -- code_actions.refactoring, -- requires refactoring plugin
          formatting.gofmt,
          formatting.stylua,
          -- sources installed with mason are setup automatically
          formatting.prettierd,
          formatting.sql_formatter,
        },
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = require("plugins.lsp.handlers").on_attach,
      }
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    opts = {
      ui = {
        theme = "round",
        border = "rounded", -- can be single,double,rounded,solid,shadow
        title = true,
        winblend = 0,
        code_action = "",
      },
      preview = {
        lines_above = 0,
        lines_below = 10,
      },
      request_timeout = 2000,
      finder = {
        keys = {
          edit = { "o", "<cr>" },
          vsplit = "s",
          split = "i",
          tabe = "t",
          quit = { "q", "<esc>" },
        },
      },
      definition = {
        edit = "<c-c>o",
        vsplit = "<c-c>v",
        split = "<c-c>i",
        tabe = "<c-c>t",
        quit = "<esc>",
      },
      code_action = {
        keys = {
          quit = "<esc>",
          exec = "<cr>",
        },
      },
      lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = true,
        -- update_time = 150,
        sign_priority = 40,
        virtual_text = false, -- show icon at the end of the line
      },
      diagnostic = {
        -- jump to diagnostic options
        jump_num_shortcut = true,
        show_code_action = true,
        show_source = true,
        keys = {
          exec_action = "o",
          quit = "<esc>",
          go_action = "g",
        },
      },
      rename = {
        keys = {
          quit = "<C-c>",
          exec = "<cr>",
          in_select = true,
        },
      },
      outline = {
        win_position = "right",
        win_with = "",
        win_width = 30,
        auto_close = false,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        custom_sort = nil,
        keys = {
          jump = "o",
          expand_collapse = "u",
          quit = { "q", "<esc>" },
        },
        -- virt_text = "┃",
        -- jump_key = "o",
        -- -- auto refresh when change buffer
        -- in_position = "right",
      },
      -- callhierarchy = {},
      symbol_in_winbar = {
        -- top outline
        enable = true,
        separator = "",
        show_file = true,
        hide_keyword = true,
        folder_level = 2,
        respect_root = false,
      },
    },
    keys = {
      { "<leader>vu", "<cmd>Lspsaga finder<CR>", desc = "lsp show references ([U]sed)" },
      {
        "<leader>va",
        "<cmd>Lspsaga code_action<CR>",
        desc = "lsp code [A]ction",
        mode = { "n", "v" },
      },
      { "<leader>vr", "<cmd>Lspsaga rename<CR>", desc = "lsp [R]ename" },
      { "<leader>vD", "<cmd>Lspsaga peek_definition<CR>", desc = "lsp peek [D]efinition" },
      { "<leader>vl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "lsp [L]ine diagnostics" },
      { "<leader>vc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "lsp [C]ursor diagnostics" },
      { "<leader>vo", "<cmd>Lspsaga outline<CR>", desc = "lsp [O]utline" },
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "hover doc" },
      { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "prev diagnostic" },
      { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "next diagnostic" },
      {
        "[E",
        function()
          require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "prev error",
      },
      {
        "]E",
        function() -- jump to errors
          require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "next error",
      },
    },
  }, -- show definitions, code actions etc.
}
