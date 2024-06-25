return {
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
            { "<leader>duo", function()
                require("dapui").open()
            end },

            { "<leader>duc", function()
                require("dapui").close()
            end },
            { "<leader>dut", function()
                require("dapui").toggle()
            end },
        },
    } }
