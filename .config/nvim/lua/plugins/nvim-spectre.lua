return {
    'nvim-pack/nvim-spectre',
    enabled = false, --
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
    },

    init = function (_)
        vim.keymap.set('n', '<leader>G',
            '<cmd>lua require("spectre").toggle()<cr>',
            { desc = 'Toggle Spectre' }
        )
    end
}
