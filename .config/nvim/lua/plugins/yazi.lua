return {
    "mikavilpas/yazi.nvim",
    event="VeryLazy",
    keys = {
        {
            "<leader>ww",
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file"
        },
        {
            "<leader>wd",
            "<cmd>Yazi cwd<cr>",
            desc = "Open yazi in the working directory"
        },
        {
            "<leader>wz",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume yazi"
        },
    },
    opts = {
        open_for_directories= false,
        keymaps = {
            show_help = '<f1>'
        },
    },
}
