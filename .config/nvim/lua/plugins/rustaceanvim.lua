return {
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
        ft = { 'rust' },
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    -- TODO: Keymaps
                end,
                default_settings = {
                    ['rust-analyzer'] = {
                        check = {
                            command = 'clippy',
                        },
                    },
                },
            },

        },
        config = function(_, opts)
            vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
            if vim.fn.executable("rust-analyzer") == 0 then
                require('lazy.util').error(
                    "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
                    { title = "rustaceanvim" }
                )
            end
            vim.notify('rustaceanvim endup configs.', vim.log.levels.WARN)
        end,
    },
}
