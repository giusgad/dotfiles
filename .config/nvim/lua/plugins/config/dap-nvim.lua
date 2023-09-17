local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
    return
end

local path = require("mason-registry").get_package("codelldb"):get_install_path() .. "/extension/adapter/codelldb"

-- autostart
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = path,
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

local dapui_ok, dapui = pcall(require, "dapui")
if dapui_ok then
    dapui.setup()
end

local dap_go_ok, dap_go = pcall(require, "dap-go")
if dap_go_ok then
    dap_go.setup({
        dap_configurations = { -- support for headless mode
            {
                type = "go",
                name = "Attach remote",
                mode = "remote",
                request = "attach",
            },
        },
    })
end

local pers_bp_ok, pers_bp = pcall(require, "persistent-breakpoints")
if pers_bp_ok then
    pers_bp.setup({
        save_dir = vim.fn.stdpath("data") .. "/nvim_breakpoints",
        -- save_dir = os.getenv("HOME") .. "/.config/nvim/undodir",
        -- when to load the breakpoints? "BufReadPost" is recommanded.
        load_breakpoints_event = "BufReadPost",
        -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
        perf_record = false,
    })
end

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
