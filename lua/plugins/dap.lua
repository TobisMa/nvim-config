return {
    "mfussenegger/nvim-dap",
    lazy=true,
    cmd="DapNew",
    init = function()
        -- Define breakpoint signs
        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        vim.fn.sign_define(
            "DapBreakpointCondition",
            { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
        )
        vim.fn.sign_define(
            "DapBreakpointRejected",
            { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
        )
        vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

        -- Define highlight colors (optional, to make it red)
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff0000" }) -- bright red
        vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#ff8800" }) -- orange
        vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00ff00" }) -- green arrow
    end,
    config = function()
        local dap = require("dap")
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
        dap.adapters.codelldb = {
            type = "executable",
            command = "codelldb",
        }
    end,
    keys={
        { "<F5>", "<cmd>DapContinue<cr>", desc = "continue debugger" },
        { "<F6>", "<cmd>DapStepOver<cr>", desc = "step over" },
        { "<F7>", "<cmd>DapStepInto<cr>", desc = "step into" },
        { "<F8>", "<cmd>DapStepOut<cr>", desc = "step out" },
        { "<F9>", "<cmd>DapTerminate<cr>", desc = "terminate debugger" },
        { "<BS>", "<cmd>DapToggleBreakpoint<cr>", desc = "terminate debugger" },
    }
}
