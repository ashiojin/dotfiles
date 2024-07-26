return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        -- '3rd/image.nvim', -- for image preview
    },

    opts = {
        close_if_last_window = true,

        commands = {
            open_and_next = function(state)
                local node = state.tree:get_node()
                if node.type == 'directory' then
                    -- open the direcotry if it closed,
                    -- and then move to next (probably the first subnode)
                    if not node:is_expanded() then
                        state.commands['open'](state)
                    end
                    vim.api.nvim_feedkeys('j', 'n', false)
                else
                    state.commands['open'](state)
                end
            end,
            open_and_close_window = function(state)
                local node = state.tree:get_node()
                if node.type == 'directory' then
                    -- open the direcotry if it closed,
                    -- and then move to next (probably the first subnode)
                    if not node:is_expanded() then
                        state.commands['open'](state)
                    end
                    vim.api.nvim_feedkeys('j', 'n', false)
                else
                    state.commands['open'](state)
                    state.commands['close_window'](state)
                end
            end
        },
        window = {
            mappings = {
                ['<leader><space>'] = {
                    'toggle_node',
                    nowait = false,
                },
                ['l'] = {
                    command = 'open_and_next',
                },
                ['<cr>'] = {
                    command = 'open_and_close_window',
                },
                ['h'] = {
                    'close_node',
                },
                ['F'] = {
                    'focus_preview',
                },
            },
        },
    },


    init = function (lazy)
        vim.keymap.set(
            'n', '<space>w', ':Neotree action=focus toggle reveal source=filesystem<CR>',
            {
                desc = ':Neotree'
            }
        )
        vim.keymap.set(
            'n', '<space>b', ':Neotree action=focus toggle reveal source=buffers<CR>',
            {
                desc = ':Neotree buffers'
            }
        )
    end,

}
