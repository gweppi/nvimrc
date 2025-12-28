-- all plugins used to configure LSPs
return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'mason-org/mason.nvim',
                opts = {},
            },
            'mason-org/mason-lspconfig.nvim',
            -- Useful status updates for LSP.
            {
                'j-hui/fidget.nvim',
                opts = {}
            },
            'saghen/blink.cmp',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    -- helper function that makes setting keymaps easier
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { desc = 'LSP: ' .. desc, buffer = event.buf })
                    end

                    -- rename variable under cursor
                    map('grn', vim.lsp.buf.rename, 'Rename')

                    -- format current buffer with lsp
                    map('grf', vim.lsp.buf.format, 'Format')

                    -- use telescope
                    local builtin = require('telescope.builtin')

                    -- find references for word under cursor
                    map('grr', builtin.lsp_references, 'List references')

                    -- goto implementation of symbol under cursor, if multiple, list in telescope
                    map('gri', builtin.lsp_implementations, 'Goto implementation')

                    -- goto definition of symbol under cursor, if multiple, list in telecope
                    map('grd', builtin.lsp_definitions, 'Goto definition')

                    -- goto definition of type of symbol under cursor, if multiple, list in telescope
                    map('grt', builtin.lsp_type_definitions, 'Goto type definition')

                    -- Highlight symbol when not moving cursor
                    -- client_id is passed to the data field by LspAttach autocmd trigger
                    local lsp_client = vim.lsp.get_client_by_id(event.data.client_id)
                    -- some lsps dont support highlighting of symbols so availability has to be checked
                    local supports_highlighting = lsp_client and lsp_client:supports_method(
                        vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
                    if supports_highlighting then
                        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                            callback = function(detach_event)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = detach_event.buf })
                            end
                        })
                    end

                    -- show inlay hints if supported by LSP
                    local supports_inlay_hints = lsp_client and lsp_client:supports_method(
                        vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                    if supports_inlay_hints then
                        vim.lsp.inlay_hint.enable()
                    end
                end
            })

            -- diagnostic config
            vim.diagnostic.config({
                underline = true,
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    severity = {
                        min = vim.diagnostic.severity.HINT
                    }
                },
                signs = true,

            })

            -- extend neovim capabilities
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- the language servers that should be / are installed
            -- see :help lspconfig-all for all options
            local servers = {
                lua_ls = {

                },
                basedpyright = {},
            }

            require('mason-lspconfig').setup({
                ensure_installed = vim.tbl_keys(servers),
                automatic_enable = true,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            })
        end,
    }
}
