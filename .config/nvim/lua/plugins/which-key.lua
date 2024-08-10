return {
--    'folke/which-key.nvim',
    dir = '~/.config/nvim/src/which-key.nvim',
    event = 'VeryLazy',
    opts = {
--        debug = true,
    },
--    version = '2.x',
    keys = {
        {
            '<leader>?',
            function ()
                require('which-key').show({ global = false })
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}
