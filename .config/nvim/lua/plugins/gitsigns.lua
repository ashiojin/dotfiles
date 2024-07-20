return {
    'lewis6991/gitsigns.nvim',
    opts = {
        -- from https://github.com/lewis6991/gitsigns.nvim#keymaps
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')
            local function map(mode, l, r, desc, opts)
                opts = opts or {}
                desc = desc or ''
                opts.buffer = bufnr
                opts.desc = desc
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigations
            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                else
                    gitsigns.nav_hunk('next')
                end
            end, 'Navication to next hunk')

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                else
                    gitsigns.nav_hunk('prev')
                end
            end, 'Navication to previous hunk')

            -- Actions
            map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage the hunk')
            map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset the hunk')
            map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, 'Stage the hunk(s)')
            map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, 'Reset the hunk(s)')
            map('n', '<leader>hS', gitsigns.stage_buffer, 'Stage all hunks in current buffer')
            map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'Undo the last call of `Stage hunk`')
            map('n', '<leader>hR', gitsigns.reset_buffer, 'Reset the lines of all hunks in the buffer')
            map('n', '<leader>hp', gitsigns.preview_hunk, 'Preview the hunk')
            map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, 'Run git-blame')
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle `gitsigns-config-current_line_blame`')
            map('n', '<leader>hd', gitsigns.diffthis, 'Show diff of the current file') -- TODO: use `DiffView`
            map('n', '<leader>hD', function() gitsigns.diffthis('~') end, 'Show idff of the current file') -- TODO: use `DiffView`
            map('n', '<leader>td', gitsigns.toggle_deleted, 'Toggle `gitsigns-config-show_deleted`')

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select the hunk')
        end,
    },
}
