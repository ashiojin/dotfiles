return {
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
        ft = { 'rust' },
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    ----------------------------
                    -- FIXME: it's WORKAROUND: https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
                    for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
                        local default_diagnostic_handler = vim.lsp.handlers[method]
                        vim.lsp.handlers[method] = function(err, result, context, config)
                            if err ~= nil and err.code == -32802 then
                                return
                            end
                            return default_diagnostic_handler(err, result, context, config)
                        end
                    end
                    ----------------------------
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
