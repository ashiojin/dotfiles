return {
    "mikavilpas/yazi.nvim",
    event="VeryLazy",
    keys = {
        {
            "<leader>w",
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file"
        },
        {
            "<leader>W",
            "<cmd>Yazi cwd<cr>",
            desc = "Open yazi in the working directory"
        },
        -- {
        --     "<leader>WW",
        --     "<cmd>Yazi toggle<cr>",
        --     desc = "Resume yazi"
        -- },
    },
    opts = {
        open_for_directories= false,
        keymaps = {
            show_help = '<f1>'
        },
    },
}
