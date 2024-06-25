return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'theHamsta/nvim-dap-virtual-text',
        "rcarriga/nvim-dap-ui",
        'mfussenegger/nvim-dap-python',
    },
    config = function()
        local dap = require("dap")
        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
        }
    end,
    keys = {
        { "<leader>dt", function() require 'dap'.toggle_breakpoint() end, "DAP toggle breakpoint" },
        { "<leader>dc", function() require 'dap'.continue() end,          "DAP continue" },
        { "<leader>do", function() require 'dap'.step_over() end,         "DAP step over" },
        { "<leader>di", function() require 'dap'.step_into() end,         "DAP step into" },
        { "<leader>dp", function() require 'dap'.repl.open() end,         "DAP open repl" },
    },
    lazy = true
}
