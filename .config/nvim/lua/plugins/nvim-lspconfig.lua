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

        -- lspconfig setups are following --

        lspconfig.lua_ls.setup{
            on_attach = function(_, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            capabilities = capabilities,
        }

        lspconfig.rust_analyzer.setup{
            on_attach = function(_, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            settings = {
                ['rust-analyzer'] = {
                    check = {
                        command = 'clippy',
                    },
                },
            },
            capabilities = capabilities,
        }

        lspconfig.bashls.setup{
            on_attach = function(_, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            capabilities = capabilities,
        }
    end,

    init = function(_)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(_)
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
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
