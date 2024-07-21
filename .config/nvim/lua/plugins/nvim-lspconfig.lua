return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',

        'ray-x/lsp_signature.nvim',
    },

    config = function()
        local lspconfig = require('lspconfig')
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local capabilities = cmp_nvim_lsp.default_capabilities()
        local lsp_signature = require('lsp_signature')
        local lsp_signature_settings = {}

--        mason.setup()
--        mason_lspconfig.setup()
        -- lspconfig setups are following --

        lspconfig.lua_ls.setup{
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path..'/.luarc.json') or
                   vim.loop.fs_stat(path..'/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT'
                    },

                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    },
                })
            end,
            on_attach = function(client, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            settings = {
                Lua = {}
            },
            capabilities = capabilities,
        }

        lspconfig.rust_analyzer.setup{
            on_attach = function(client, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            capabilities = capabilities,
        }

        lspconfig.bashls.setup{
            on_attach = function(client, bufnr)
                lsp_signature.on_attach(lsp_signature_settings, bufnr)
            end,
            capabilities = capabilities,
        }
    end,
}
