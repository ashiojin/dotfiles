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

        auto_clean_after_session_restore = true,

        sources = {'filesystem', 'buffers', 'git_status', 'document_symbols'},

        commands = {
            open_and_next = function(state)
                -- TODO: In `document_symbols`, a node can be opened in a buffer and
                -- can have children. In this case, I want to open the node if it is
                -- expanded, otherwise I just want to expand it.
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
                -- TODO: Extract common code with open_and_next()
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
            end,
            reload_and_reflesh = function(state)
                state.commands['refresh'](state)
                vim.cmd([[nohlsearch]])
                vim.api.nvim_feedkeys('<C-l>', 'n', false)
            end,
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
                ['<C-l>'] = {
                    command = 'reload_and_reflesh',
                },
            },
        },
        buffers = {
            show_unloaded = true,
        }
    },


    init = function (_)
        vim.keymap.set(
            'n', '<space><c-w>', ':Neotree action=focus toggle reveal source=filesystem<CR>',
            {
                desc = 'Neotree filesystem'
            }
        )
        -- vim.keymap.set(
        --     'n', '<space>b', ':Neotree action=focus toggle reveal right source=buffers<CR>',
        --     {
        --         desc = 'Neotree buffers'
        --     }
        -- )
        vim.keymap.set(
            'n', '<space>o', ':Neotree action=focus toggle reveal source=document_symbols<CR>',
            {
                desc = 'Neotree document symbols'
            }
        )
    end,

}
