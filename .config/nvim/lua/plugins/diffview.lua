return {
    "sindrets/diffview.nvim",
    config = true,
    keys = {
        { "<leader>gd", ":DiffviewOpen<cr>",          desc = "Open diff view" },
        { "<leader>gs", ":DiffviewOpen<cr>",          desc = "Open Merge resolution" },
        { "<leader>gh", ":DiffviewFileHistory %<cr>", desc = "Open diff view" },
        { "<leader>gH", ":DiffviewFileHistory <cr>",  desc = "Open diff view" },
        { "<leader>gq", ":DiffviewClose <cr>",        desc = "Open diff view" },
    },
}
