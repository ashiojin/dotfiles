return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',

            -- adapters
            'mrcjkb/rustaceanvim',
        },
        config = function (_, opts)
            opts.adapters = { require('rustaceanvim.neotest'), }
            require('neotest').setup(opts)
        end
    },
}
