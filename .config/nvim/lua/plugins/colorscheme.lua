return {
    {
        'folke/tokyonight.nvim',

        lazy = false, -- main colorscheme should be loaded during startup.
        priority = 1000, -- colorscheme should be loaded before the other plugins
        config = function ()
            -- vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        'rebelot/kanagawa.nvim',

        lazy = false, -- main colorscheme should be loaded during startup.
        priority = 1000, -- colorscheme should be loaded before the other plugins
        config = function ()
            -- vim.cmd([[colorscheme kanagawa-dragon]])
        end,
    },

    {
        'craftzdog/solarized-osaka.nvim',

        lazy = false, -- main colorscheme should be loaded during startup.
        priority = 1000, -- colorscheme should be loaded before the other plugins
        config = function ()
            vim.cmd([[colorscheme solarized-osaka]])
        end,
    },
}
