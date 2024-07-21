return {
    'ldelossa/nvim-dap-projects',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    init = function(_)
        vim.api.nvim_create_user_command(
            'DapLoadSetting',
            function (opts)
                require('nvim-dap-projects')
                    .search_project_config()
            end,
            {
                desc = 'Search nvim-dap config file of the project',
            }
        )
    end,
}
