return {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
    opts = {
        enable = true,
        max_lines = 5,
        multiline_threshold = 5,
    },
    keys = {
        vim.keymap.set("n", "<leader>ctc", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { silent = true })
    },
    lazy = false
}
