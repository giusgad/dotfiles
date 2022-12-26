-- require("dap").defaults.fallback.terminal_win_cmd = ""

require("dap-go").setup()
require("dapui").setup()

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#fb4934" })
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapStopped", { text = "" })
