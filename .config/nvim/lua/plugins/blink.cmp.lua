return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',

    -- @module: 'blink.cmp'
    -- @type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',

            ['<C-n>'] = { function(cmp)
                if cmp.is_visible() then
                    cmp.select_next()
                else
                    cmp.show()
                end
            end},
            ['<C-p>'] = { function(cmp)
                if cmp.is_visible() then
                    cmp.select_prev()
                else
                    cmp.show()
                end
            end},
            ['<C-]>'] = {
                function(cmp)
                    cmp.hide() -- or `cmp.cancel()` ?
                    return false
                end,
                'fallback_to_mappings', -- for Copilot-lua
            },
        },
    }

}
