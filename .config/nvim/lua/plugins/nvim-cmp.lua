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
    enabled = false,

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

            formatting = {
                format = function (_entry, vim_item) -- FIXME: WORKAROUND: A completion list window takes up entire window width, leaving a document window without enough width.
                    local win_width = vim.fn.winwidth(0)
                    local max_menu_width = (win_width - 20) / 3
                    -- | abbr | kind(?) | menu     |
                    -- shorten `menu`
                    if vim_item.menu ~= nil and #vim_item.menu > max_menu_width then
                        vim_item.menu = string.sub(vim_item.menu, 1, max_menu_width) .. '…'
                    end
                    return vim_item
                end,
            },

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
