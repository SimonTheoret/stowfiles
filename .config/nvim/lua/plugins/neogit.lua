return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
        local neogit = require("neogit")
        neogit.setup {
            graph_style = "unicode",
            commit_editor = { kind = "tab", staged_diff_split_kind = "auto" }
        }
    end,
    keys = {
        {
            "<leader>g/",
            function()
                require('neogit').open({ kind = "auto" })
            end,
            desc = "Neogit"
        },
        {
            "<leader>g?",
            ":Neogit help<CR>",
            desc = "Neogit help"
        }
    },
}
