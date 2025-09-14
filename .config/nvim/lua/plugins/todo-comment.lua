return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
    },
    keys = {
        { '<leader>fT', ':TodoTelescope<CR>', desc = 'TodoTelescope' },
    },
}
