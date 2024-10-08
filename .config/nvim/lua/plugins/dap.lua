return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'theHamsta/nvim-dap-virtual-text',
        "rcarriga/nvim-dap-ui",
        'mfussenegger/nvim-dap-python',
        "Joakker/lua-json5",
        "ibhagwan/fzf-lua",
    },
    config = function()
        local dap = require("dap")
        require('dap.ext.vscode').json_decode = require 'json5'.parse
        dap.configurations.rust = {
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
        { "<leader>dt", function() require('dap').toggle_breakpoint() end,  desc = "DAP toggle breakpoint" },
        { "<leader>dc", function() require('dap').continue() end,           desc = "DAP continue" },
        { "<leader>do", function() require('dap').step_over() end,          desc = "DAP step over" },
        { "<leader>di", function() require('dap').step_into() end,          desc = "DAP step into" },
        { "<leader>dr", function() require('dap').repl.open() end,          desc = "DAP open repl" },
        { "<leader>dh", function() require('dap.ui.widgets').hover() end,   desc = "DAP hover" },
        { "<leader>dp", function() require('dap.ui.widgets').preview() end, desc = "DAP preview" },
        {
            "<leader>df",
            function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end,
            desc = "DAP frames"
        },
        {
            "<leader>ds",
            function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end,
            desc = "DAP scopes"
        },
        {
            "<leader>dl",
            function()
                require('fzf-lua').dap_command()
            end,
            desc = "List dap command"
        },
        {
            "<leader>db",
            function()
                require('fzf-lua').dap_breakpoints()
            end,
            desc = "List dap breakpoints"
        },
    },
    lazy = true
}
