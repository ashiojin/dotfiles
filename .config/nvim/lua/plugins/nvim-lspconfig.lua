return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',

        'ray-x/lsp_signature.nvim',
    },

    config = function()
        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local capabilities = cmp_nvim_lsp.default_capabilities()
        local lsp_signature = require('lsp_signature')
        local lsp_signature_settings = {}

        ------------------------------------
        -- lspconfig setups are following --

        -- Lua
        lspconfig.lua_ls.setup{
            on_attach = function(_, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            capabilities = capabilities,
        }

        -- Removed rust-analyzer setup since 2024/10/11 because of starting to use rustaceanvim which will set up rust-analizer
        -- (see: https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#zap-quick-setup)
        -- -- Rust
        -- lspconfig.rust_analyzer.setup{
        --     on_attach = function(_, bufnr)
        --         lsp_signature.on_attach(lsp_signature_settings, bufnr)
        --     end,
        --     settings = {
        --         ['rust-analyzer'] = {
        --             check = {
        --                 command = 'clippy',
        --             },
        --         },
        --     },
        --     capabilities = capabilities,
        -- }

        -- Bash
        lspconfig.bashls.setup{
            on_attach = function(_, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            capabilities = capabilities,
        }

        -- Typescript (Plugins: Vue)
        local vue_language_server_path = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
        lspconfig.ts_ls.setup{
            -- on_attach = function(_, bufnr)
            --     lsp_signature.on_attach(lsp_signature_settings, bufnr)
            -- end,
            -- capabilities = capabilities,
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vue_language_server_path,
                        languages = { 'vue' },
                    },
                },
            },
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        }

        lspconfig.volar.setup{
            on_attach = function(_, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            capabilities = capabilities,
        }
        -- lspconfig.vuels.setup{
        --     on_attach = function(_, bufnr)
        --         lsp_signature.on_attach(lsp_signature_settings, bufnr)
        --     end,
        --     capabilities = capabilities,
        -- }
        --
        --                                --
        ------------------------------------
    end,

    init = function(_)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(_)
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
                vim.keymap.set('n', '<c-k>', '<cmd>lua vim.diagnostic.open_float()<CR>')
                vim.keymap.set('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
                vim.keymap.set('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>')
                vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>')
                vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>')
                vim.keymap.set('n', '<leader>T', '<cmd>lua vim.lsp.buf.type_definition()<CR>')

                vim.keymap.set('n', '<leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>')

                vim.keymap.set('n', '<leader>F', '<cmd>lua vim.lsp.buf.format()<CR>')
                vim.keymap.set('x', '<leader>F', '<cmd>lua vim.lsp.buf.format()<CR>')

                vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
                vim.keymap.set('x', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
            end,
        })
    end,
}
