return {
    'mfussenegger/nvim-dap',
    init = function(_)
        local dap = require('dap')

        local data_path = vim.fn.stdpath('data')
        local codelldb_path = data_path .. '/mason/bin/codelldb'

        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = codelldb_path,
                args = { '--port', '${port}' },
            },
        }

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


        -- Key Mappings
        vim.keymap.set('n', '<f5>', function()
            dap.continue()
        end, { desc = 'Continue' })

    end,
}
