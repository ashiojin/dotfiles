return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },

    opts = {
        defaults = {
            layout_strategy = 'vertical',
            layout_config = {
                width = 0.8,
                height = 0.9,
                preview_cutoff = 40,
                prompt_position = 'bottom',
            },
            mappings = {
                n = {
                    ['<C-U>'] = 'results_scrolling_up',
                    ['<C-D>'] = 'results_scrolling_down',
                    ['<C-L>'] = 'results_scrolling_up',
                    ['<C-H>'] = 'results_scrolling_down',
                    ['<PageUp>'] = 'preview_scrolling_up',
                    ['<PageDown>'] = 'preview_scrolling_down',
                },
                i = {
                    ['<C-U>'] = false,

                    ['<C-L>'] = 'results_scrolling_up',
                    ['<C-H>'] = 'results_scrolling_down',
                    ['<PageUp>'] = 'preview_scrolling_up',
                    ['<PageDown>'] = 'preview_scrolling_down',
                },
            },
        },
    },

    keys = {
        {
            "<leader>ff",
            function()
                require("telescope.builtin")
                    .resume({})
            end,
            desc = "Resume Telescope",
        },
        {
            "<leader>fw",
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
            "<leader>b",
            function()
                require("telescope.builtin")
                    .buffers({})
            end,
            desc = "Find Open Buffers",
        },
        {
            "<leader>fd",
            function()
                require("telescope.builtin")
                    .diagnostics({})
            end,
            desc = "Find Diagnostics",
        },
        {
            "<leader>fs",
            function()
                require("telescope.builtin")
                    .lsp_document_symbols({})
            end,
            desc = "Find Document Symbols",
        },
        {
            "<leader>fj",
            function()
                require("telescope.builtin")
                    .jumplist({})
            end,
            desc = "Find Jumplist",
        },

    },
}
