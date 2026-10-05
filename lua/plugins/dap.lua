-- Debugging core. Adapters are per language: each langs/*.lua lists its
-- debugger under `tools` and wires it up in `plugins`.
local function dap(fn, ...)
    local args = { ... }
    return function()
        require("dap")[fn](unpack(args))
    end
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "igorlfs/nvim-dap-view",
            { "theHamsta/nvim-dap-virtual-text", opts = {} },
        },
        keys = {
            { "<leader>db", dap("toggle_breakpoint"), desc = "Toggle breakpoint" },
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Condition: "))
                end,
                desc = "Conditional breakpoint",
            },
            {
                "<leader>dL",
                function()
                    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log: "))
                end,
                desc = "Logpoint",
            },
            { "<leader>dX", dap("clear_breakpoints"), desc = "Clear breakpoints" },
            { "<leader>dc", dap("continue"), desc = "Continue / start" },
            { "<leader>dC", dap("run_to_cursor"), desc = "Run to cursor" },
            { "<leader>dl", dap("run_last"), desc = "Run last" },
            { "<leader>do", dap("step_over"), desc = "Step over" },
            { "<leader>di", dap("step_into"), desc = "Step into" },
            { "<leader>dO", dap("step_out"), desc = "Step out" },
            { "<leader>dj", dap("down"), desc = "Frame down" },
            { "<leader>dk", dap("up"), desc = "Frame up" },
            { "<leader>dp", dap("pause"), desc = "Pause" },
            { "<leader>dt", dap("terminate"), desc = "Terminate" },
            {
                "<leader>du",
                function()
                    require("dap-view").toggle()
                end,
                desc = "Toggle debug view",
            },
            {
                "<leader>dw",
                function()
                    require("dap-view").add_expr()
                end,
                mode = { "n", "x" },
                desc = "Watch expression",
            },
            {
                "<leader>de",
                function()
                    require("dap.ui.widgets").hover()
                end,
                mode = { "n", "x" },
                desc = "Evaluate under cursor",
            },
        },
        config = function()
            -- The view opens when a session starts and closes when it ends.
            require("dap-view").setup({ auto_toggle = true })

            local signs = {
                DapBreakpoint = { "●", "DiagnosticError" },
                DapBreakpointCondition = { "◆", "DiagnosticWarn" },
                DapLogPoint = { "◆", "DiagnosticInfo" },
                DapBreakpointRejected = { "○", "DiagnosticHint" },
                DapStopped = { "→", "DiagnosticOk" },
            }
            for name, sign in pairs(signs) do
                vim.fn.sign_define(name, {
                    text = sign[1],
                    texthl = sign[2],
                    linehl = name == "DapStopped" and "Visual" or "",
                })
            end
        end,
    },
}
