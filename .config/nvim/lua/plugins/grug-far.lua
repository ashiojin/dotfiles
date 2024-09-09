return {
    "MagicDuck/grug-far.nvim",
    opts = {
    },
    init = function (_)
        vim.keymap.set('n', '<leader>G',
            '<cmd>GrugFar<cr>',
            { desc = 'Open grug-far.nvim' }
        )
    end
}
