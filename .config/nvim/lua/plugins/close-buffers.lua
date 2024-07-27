return {
    'kazhala/close-buffers.nvim',
    opts = {
    },

    init = function (_)
        vim.keymap.set('n', '<leader>qt', function ()
            require('close_buffers').delete({ type = 'this' })
        end, { desc = 'Close the current focused buffer' })
        vim.keymap.set('n', '<leader>qh', function ()
            require('close_buffers').delete({ type = 'hidden' })
        end, { desc = 'Close all non-visible buffers' })
        vim.keymap.set('n', '<leader>qo', function ()
            require('close_buffers').delete({ type = 'other' })
        end, { desc = 'Close all buffers except the current focused buffer' })
    end,
}
