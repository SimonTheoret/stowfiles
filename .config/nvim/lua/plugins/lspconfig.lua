return {
    "neovim/nvim-lspconfig",
    config = function()
        -- setups LSPs
        local lspconfig = require('lspconfig')

        -- Set up cmp with lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- python LSP
        lspconfig.pyright.setup {
            capabilities = capabilities,
            settings = {
                pyright = { autoImportCompletion = true, },
                python = { analysis = { autoSearchPaths = true, diagnosticMode = "workspace", useLibraryCodeForTypes = true, } }
            }
        }
        lspconfig.ruff_lsp.setup {
            init_options = {
                settings = {
                    -- Any extra CLI arguments for `ruff` goes here.
                    args = {},
                }
            }
        }

        lspconfig.rust_analyzer.setup({ -- rust LSP
            -- Server-specific settings. See `:help lspconfig-setup`
            -- on_attach = function(client, bufnr)
            --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            -- end,
            capabilities = capabilities,
            settings = {
                ['rust-analyzer'] = {
                    completion = {
                        fullFunctionSignatures = { enable = true }
                    },
                    hover = {
                        actions = { enable = true }
                    },
                    check = {
                        command = "clippy"
                    },
                    cargo = {
                        allFeatures = true,
                    },
                    files = {
                        excludeDirs = { os.getenv("HOME").."/.cargo" }
                    }
                },
            },
        })
        -- Lua lsp
        lspconfig.lua_ls.setup {
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    diagnostics = {
                        globals = { 'vim', 'require' }
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- Depending on the usage, you might want to add additional paths here.
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                })
            end,
            settings = {
                Lua = {}
            }
        }

        lspconfig.gopls.setup({ -- go LSP
            capabilities = capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                        useany = true,
                        unusedvariable = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                    completeUnimported = true,
                    usePlaceholders = true,
                },
            },
        })

        -- Nix lsp
        lspconfig.nil_ls.setup({})

        -- Latex Texlab
        lspconfig.texlab.setup({})

        -- markdown
        lspconfig.marksman.setup({})

        -- bash lsp
        lspconfig.bashls.setup({})

        -- clang lsp
        lspconfig.clangd.setup({})

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "diagnostic" })
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "loclist" })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- so gq might work again
                vim.bo[ev.buf].formatexpr = nil

                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Lsp declaration", buffer = ev.buf })

                vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end,
                    { desc = "LSP definition", buffer = ev.buf })

                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Lsp informations", buffer = ev.buf })

                vim.keymap.set('n', 'gI', function() require('telescope.builtin').lsp_implementations() end,
                    { desc = "LSP implementations", buffer = ev.buf })

                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Lsp signature", buffer = ev.buf })

                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,
                    { desc = "Lsp add workspace folder", buffer = ev.buf })

                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                    { desc = "Lsp remove workspace folder", buffer = ev.buf })

                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { desc = "Lsp list workspace folders", buffer = ev.buf })

                vim.keymap.set('n', '<leader>D', function() require('telescope.builtin').lsp_type_definitions() end,
                    { desc = "LSP type definition", buffer = ev.buf })

                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Lsp rename", buffer = ev.buf })

                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action,
                    { desc = "Lsp code action", buffer = ev.buf })

                vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end,
                    { desc = "Lsp references", buffer = ev.buf })

                vim.keymap.set('n', '<space>fo', function()
                    vim.lsp.buf.format { async = true }
                end, { desc = "Lsp format buffer", buffer = ev.buf })

                vim.keymap.set('n', '<leader>fi',
                    function() require('telescope.builtin').lsp_dynamic_workspace_symbols {} end,
                    { desc = "Lsp workspace symbols", buffer = ev.buf })

                vim.keymap.set('n', '<leader>fj', function() require('telescope.builtin').lsp_document_symbols() end,
                    { desc = "Lsp document symbols", buffer = ev.buf })

                vim.keymap.set('n', '<leader>co', function() require('telescope.builtin').lsp_outgoing_calls() end,
                    { desc = "LSP outgoing calls", buffer = ev.buf })

                vim.keymap.set('n', '<leader>ci', function() require('telescope.builtin').lsp_incoming_calls() end,
                    { desc = "LSP incoming calls", buffer = ev.buf })

                vim.keymap.set('n', '<leader>fq', function() require('telescope.builtin').diagnostics() end,
                    { desc = "Telescope diagnostics", buffer = ev.buf })

                vim.keymap.set('n', '<leader>th',
                    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
                    { desc = "Toggle inlay hints", buffer = ev.buf })
            end,
        })
    end,
}
