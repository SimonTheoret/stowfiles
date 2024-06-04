return {
    "lervag/vimtex",
    lazy = false,
    config = function()
        vim.g.vimtex_view_method = 'zathura'

        -- Vim autocomands
        vim.api.nvim_create_autocmd({ "BufRead" }, {
            pattern = { "*.tex", "*.bib", "*.sty" },
            callback = function(_)
                vim.api.nvim_buf_set_keymap(0, "n", "<localleader>cc", ":VimtexCompile<CR>",
                    { desc = "Compile current TeX file" })

                vim.api.nvim_buf_set_keymap(0, "n", "<localleader>cv", ":VimtexView<CR>",
                    { desc = "View current TeX file" })

                vim.api.nvim_buf_set_keymap(0, "n", "<localleader>cC", ":VimtexClean<CR>",
                    { desc = "Clean current TeX directory" })

                vim.api.nvim_buf_set_keymap(0, "n", "<localleader>cl", ":VimtexLog<CR>",
                    { desc = "View current log" })
            end
        })
    end,
}
