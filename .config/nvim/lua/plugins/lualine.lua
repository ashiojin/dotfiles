return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = {
        sections = {
            lualine_c = {
                {'filename', path=1},
            }
        }
    }
    -- opts = function(_, opts)
    --     table.remove(opts.sections.lualine_c, 1)
    --     table.insert(opts.sections.lualine_c, {
    --         {
    --             'filename',
    --             path = 1,
    --         },
    --     })
    -- end,
}
