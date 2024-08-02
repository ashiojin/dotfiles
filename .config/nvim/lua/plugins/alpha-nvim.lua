return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'folke/persistence.nvim',
    },

    config = function ()
        local alpha = require('alpha')
        local startify = require('alpha.themes.startify')

        local config = startify.config

        table.insert(
            startify.section.top_buttons.val,
            startify.button('s', 'Open session', '<cmd>lua require("persistence").load()<cr>')
        )
--        startify.section.top_buttons.val:insert({
--            startify.button('s', 'Open session', '<cmd>lua require("persistence").load()<cr>')
--
--        })

        config.layout[4] = startify.section.top_buttons

        alpha.setup(config)
    end
}
