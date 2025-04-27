return {
    'numToStr/Comment.nvim',
    enabled = true,
--    lazy=false,
   -- event = "BufReadPre",

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
--        'JoosepAlviste/nvim-ts-context-commentstring'
    },
    opts = {},

    -- config = function ()
    --     local prehook_ = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    --     require('Comment').setup({
    --         pre_hook = prehook_,
    --
    --     })
    -- end,

}
