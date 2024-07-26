return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mason.nvim" },
    config = function()
      local dap = require("dap")
      local lldb_bin = require("mason-registry").get_package("codelldb"):get_install_path()
        .. "/extension/adapter/codelldb"
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = lldb_bin,
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.rust = dap.configurations.cpp
      dap.configurations.c = dap.configurations.cpp
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = true,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        -- hide repl buffer
        pattern = "dap-repl",
        callback = function(args)
          vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
        end,
      })
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#fb4934" })
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapStopped", { text = "" })
    end,
  },
  {
    "jayp0521/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = { automatic_setup = true },
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    opts = {
      save_dir = vim.fn.stdpath("data") .. "/nvim_breakpoints",
      load_breakpoints_event = "BufReadPost",
      perf_record = false,
    },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    opts = {
      dap_configurations = { -- support for headless mode
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
    },
  }, -- go debugging with delve
}
