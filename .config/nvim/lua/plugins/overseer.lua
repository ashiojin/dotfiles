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

    init = function (_)
        vim.keymap.set('n', '<leader>OO', ':OverseerToggle<cr>')
        vim.keymap.set('n', '<leader>OR', ':OverseerRun<cr>')
        vim.keymap.set('n', '<leader>OC', ':OverseerRunCmd<cr>')
    end


}
