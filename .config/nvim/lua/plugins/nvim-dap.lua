return {
    'mfussenegger/nvim-dap',
    init = function(_)
        local dap = require('dap')

        local data_path = vim.fn.stdpath('data')

        ---- Addapters ----
        -- Codelldb
        local codelldb_path = data_path .. '/mason/bin/codelldb'
        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = codelldb_path,
                args = { '--port', '${port}' },
            },
        }

        -- vscode-js-debug
        local dap_debug_server_path = data_path .. '/mason/bin/js-debug-adapter'
        dap.adapters['pwa-node'] = {
            type = 'server',
            host = 'localhost',
            port = '${port}',
            executable = {
                command = dap_debug_server_path,
                args = { '${port}' }
            }
        }

        ---- Languages ----
        -- Rust
        dap.configurations.rust = {
            {
                name = 'Launch file',
                type = 'codelldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                -- showDisassembly = 'never',
            },
        }

        -- Javascript
        dap.configurations.javascript = {
            {
                type = 'pwa-node',
                request = 'launch',
                name = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
            },
        }

        -- Key Mappings
        vim.keymap.set('n', '<f5>', function() dap.continue() end, { desc = 'Continue' })
        vim.keymap.set('n', '<f10>', function() dap.step_over() end, { desc = 'Step over' })
        vim.keymap.set('n', '<f11>', function() dap.step_into() end, { desc = 'Step into' })
        vim.keymap.set('n', '<f12>', function() dap.step_out() end, { desc = 'Step out' })
        vim.keymap.set('n', '<leader><c-b>', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
        vim.keymap.set('n', '<leader><c-t>', function() dap.set_breakpoint(nil, nil, vim.fn.input('Trace point message: ')) end)
        vim.keymap.set('n', '<leader>DL', function() dap.run_last() end, { desc = 'Re-runs the last debug adapter/configuration' })

    end,
}
