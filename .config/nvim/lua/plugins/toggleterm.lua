return {
    'akinsho/toggleterm.nvim',
    keys = {
        { '<leader>S', ':ToggleTerm<CR>', desc = 'ToggleTerm' },
    },
    version = '*',
    opts = {
    },
    init = function()
        local group = vim.api.nvim_create_augroup('ToggleTermKey', { clear = true })
        vim.api.nvim_create_autocmd('TermOpen',
            {
                group = group,
                callback = function()
                    local opts = { buffer = 0 }

                    -- window operations
                    vim.keymap.set('t', '<c-w>', [[<c-\><c-n><c-w]], opts)
                end
            }
        )
    end
}
