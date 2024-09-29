return {
    'stevearc/overseer.nvim',
    dependencies = {
        'stevearc/dressing.nvim',
        "nvim-telescope/telescope.nvim",
    },

    opts = {
        -- TODO: customs for `makers`
        -- TODO: integration with toggleterm : https://github.com/stevearc/overseer.nvim/blob/master/doc/third_party.md#toggleterm
    },

    keys = {
        {
            '<leader>OQ',
            '<cmd>OverseerClose<cr>',
            mode = 'n',
            desc = "Close Overseer",
        },
        {
            '<leader>OO',
            '<cmd>OverseerOpen<cr>',
            mode = 'n',
            desc = "Open(or forcus) Overseer",
        },
        {
            '<leader>OR',
            '<cmd>OverseerRun<cr>',
            mode = 'n',
            desc = "Select new task for Overseer",
        },
        {
            '<leader>OC',
            '<cmd>OverseerRunCmd<cr>',
            mode = 'n',
            desc = "Input new task for Overseer",
        },
    },
}
