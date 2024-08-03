return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'folke/lazydev.nvim',
        -- TODO: Add snippet sources & its settings
        -- 'hrsh7th/vim-vsnip'
        -- 'hrsh7th/cmp-vsnip'
    },

    config = function()
        local cmp = require('cmp')
        local opts = {
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                -- { name = 'vsnip' },
                { name = 'lazydev', group_index = 0 },
            }, {
                { name = 'buffer' },
            }),

            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),

            window = {
                -- TODO: What is this?
            },
            snippet = {
                -- TODO: Add snippet sources & its settings
                -- expand = function(args)
                --     vim.fn['vsnip#anonymous'](args.body)
                -- end,
            }
        }
        cmp.setup(opts)

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' },
                    },
                },
            }),
            matching = {
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
                disallow_partial_fuzzy_matching = true,
                disallow_partial_matching = false,
                disallow_prefix_unmatching = false,
                disallow_symbol_nonprefix_matching = false,
            },
        })
    end,
}
