return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        'AndreM222/copilot-lualine',
        "nvim-tree/nvim-web-devicons",
    },

    opts = {
        sections = {
            lualine_c = {
                { 'filename', path = 1 },
            },
            lualine_x = {
                {
                    'copilot',
                    show_colors = true,
                    show_loading = true,
                },
                'encoding', 'fileformat', 'filetype',
            },
        },
    }
}
