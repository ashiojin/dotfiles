return {
    'Wansmer/treesj',
    keys = {
        { '<leader>tt', ':TSJToggle<CR>', desc = 'TSJToggle' },
        { '<leader>tj', ':TSJSplit<CR>', desc = 'TSJSplit' },
        { '<leader>ts', ':TSJJoin<CR>', desc = 'TSJJoin' },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
        use_default_keymaps = false,
    },
}
