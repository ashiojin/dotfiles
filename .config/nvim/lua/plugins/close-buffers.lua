return {
    'kazhala/close-buffers.nvim',
    opts = {
    },

    init = function (_)
        vim.keymap.set('n', '<leader>QT', function ()
            require('close_buffers').delete({ type = 'this' })
        end, { desc = 'Close the current focused buffer' })
        vim.keymap.set('n', '<leader>QH', function ()
            require('close_buffers').delete({ type = 'hidden' })
        end, { desc = 'Close all non-visible buffers' })
        vim.keymap.set('n', '<leader>QO', function ()
            require('close_buffers').delete({ type = 'other' })
        end, { desc = 'Close all buffers except the current focused buffer' })
    end,
}
