return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function (_, opts)
        require('nvim-autopairs').setup(opts)

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        if cmp then
            -- mapping 'CR' for nvim-autopairs with nvim-cmp
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    end
}
