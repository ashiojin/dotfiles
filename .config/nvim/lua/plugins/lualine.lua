return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = function(_, opts)
--        table.insert(opts.sections.lualine_x, "😊")
    end,
}
