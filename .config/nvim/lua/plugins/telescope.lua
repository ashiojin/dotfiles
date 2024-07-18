return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },

    keys = {
        {
            "<leader>ff",
            function()
                require("telescope.builtin")
                    .find_files({})
            end,
            desc = "Find File",
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin")
                    .live_grep({})
            end,
            desc = "Grep",
        },
        {
            "<leader>fb",
            function()
                require("telescope.builtin")
                    .buffers({})
            end,
            desc = "Find Open Buffers",
        },
    },
}
