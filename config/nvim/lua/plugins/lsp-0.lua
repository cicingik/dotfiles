return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'b0o/schemastore.nvim' }
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })

                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = bufnr, silent = true, desc = 'LSP: ' .. desc })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-T>.
                map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')

                -- Find references for the word under your cursor.
                map('gr', require('telescope.builtin').lsp_references, 'Goto References')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')

                -- Fuzzy find all the symbols in your current workspace
                --  Similar to document symbols, except searches over your whole project.
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

                -- Rename the variable under your cursor
                --  Most Language Servers support renaming across files, etc.
                map('<leader>rn', vim.lsp.buf.rename, 'Rename')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

                -- Opens a popup that displays documentation about the word under your cursor
                map('<leader>k', vim.lsp.buf.hover, 'Hover Documentation')

                -- Restarting LSP Server
                map('<leader>R', "<cmd>LspRestart<cr>", 'Restart LSP')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header
                map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
            end)


            local lspconfig = require('lspconfig')

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "bashls",
                    -- clangd
                    -- eslint-lsp
                    -- gofumpt
                    -- goimports
                    "gopls",
                    -- helm-ls
                    "jsonls",
                    "lua_ls",
                    -- markdownlint-cli2
                    -- marksman
                    -- pyright
                    "pylsp",
                    "robotframework_ls",
                    -- ruff
                    -- ruff-lsp
                    "rust_analyzer",
                    -- typescript-language-server
                    "vimls",
                    -- yamlfmt
                    -- yamllint
                    -- yq
                },
                handlers = {
                    lsp_zero.default_setup,
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "custom_nvim" },
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    checkThirdParty = false,
                                    hint = { enable = true },
                                    telemetry = { enable = false },
                                },
                            },
                        },
                    }),

                    lspconfig.pylsp.setup({
                        settings = {
                            pylsp = {
                                plugins = {
                                    pycodsyle = {
                                        ignore = { 'W391', 'E501' },
                                        maxLineLength = 120
                                    }
                                }
                            }
                        }
                    }),

                    lspconfig.jsonls.setup({
                        settings = {
                            json = {
                                schema = require('schemastore').json.schemas(),
                                validate = { enable = true },
                            }
                        }
                    }),

                    lspconfig.rust_analyzer.setup({
                        settings = {
                            ["rust-analyzer"] = {
                                lens = {
                                    enable = true,
                                },
                                cargo = {
                                    allFeatures = true,
                                    loadOutDirsFromCheck = true,
                                    runBuildScripts = true,
                                },
                                -- Add clippy lints for Rust.
                                check = {
                                    enable = true,
                                    allFeatures = true,
                                    command = "clippy",
                                    extraArgs = { "--no-deps" },
                                },
                                procMacro = {
                                    enable = true,
                                    ignored = {
                                        ["async-trait"] = { "async_trait" },
                                        ["napi-derive"] = { "napi" },
                                        ["async-recursion"] = { "async_recursion" },
                                    },
                                },
                            },
                        },
                    }),

                    lspconfig.gopls.setup({
                        settings = {
                            gopls = {
                                gofumpt = true,
                                codelenses = {
                                    gc_details = false,
                                    generate = true,
                                    regenerate_cgo = true,
                                    run_govulncheck = true,
                                    test = true,
                                    tidy = true,
                                    upgrade_dependency = true,
                                    vendor = true,
                                },
                                hints = {
                                    assignVariableTypes = true,
                                    compositeLiteralFields = true,
                                    compositeLiteralTypes = true,
                                    constantValues = true,
                                    functionTypeParameters = true,
                                    parameterNames = true,
                                    rangeVariableTypes = true,
                                },
                                analyses = {
                                    fieldalignment = true,
                                    nilness = true,
                                    unusedparams = true,
                                    unusedwrite = true,
                                    useany = true,
                                },
                                usePlaceholders = true,
                                completeUnimported = true,
                                staticcheck = true,
                                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                            }
                        }
                    }),

                    lspconfig.robotframework_ls.setup({
                        cmd = { 'robotframework_ls' },
                    }),

                    lspconfig.helm_ls.setup {
                        settings = {
                            ['helm-ls'] = {
                                yamlls = {
                                    path = "yaml-language-server",
                                }
                            }
                        }
                    },

                    lspconfig.ts_ls.setup {
                        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
                        root_dir = function() return vim.loop.cwd() end -- run lsp for javascript in any directory

                    }
                },
            })

            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['rust_analyzer'] = { 'rust' },
                    ['gopls'] = { 'go' },
                    ['robotframework_ls'] = { 'robotframework_ls' },
                    ['helm_ls'] = { 'helm_ls' },
                    ['ts_ls'] = { 'ts_ls' },
                }
            })

            lsp_zero.set_preferences({
                suggest_lsp_servers = false,
            })

            lsp_zero.set_sign_icons({
                hint = '',
                info = '',
                warning = '',
                error = ''
            })
        end
    }
}
