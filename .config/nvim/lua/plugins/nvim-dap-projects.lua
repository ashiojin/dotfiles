return {
    'ldelossa/nvim-dap-projects',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    enabled = false, -- I use `.vim/init.lua` for project specific configs
    init = function(_)
        vim.api.nvim_create_user_command(
            'DapLoadSetting',
            function (_)
                require('nvim-dap-projects')
                    .search_project_config()
            end,
            {
                desc = 'Search nvim-dap config file of the project',
            }
        )
    end,
}
