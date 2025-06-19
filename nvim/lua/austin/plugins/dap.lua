return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        { "theHamsta/nvim-dap-virtual-text", opts = {}},
    },
    keys = {
        {"<leader>du", function() require("dapui").toggle() end, desc = "Toggle Dap UI"},
        {"<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint"},
        {"<leader>dc", function() require("dap").continue() end, desc = "Debug Run/Continue"},
        {"<leader>di", function() require("dap").step_into() end, desc = "Step into"},
        {"<leader>do", function() require("dap").step_over() end, desc = "Step over"},
        {"<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle repl"},
        {"<leader>dt", function() require("dap-go").debug_test() end, desc = "Debug test"},
        {"<leader>dd", vim.diagnostic.open_float, desc = "Show diagnostic"},
    },
    config = function()
        require('dap-go').setup()
        local dapui = require("dapui")
        dapui.setup()

        local dap = require("dap")

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end

        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
    end

}
