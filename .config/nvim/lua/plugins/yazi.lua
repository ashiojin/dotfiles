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
        open_file_function = function(chosen_file, config, state)
            local openers = require('yazi.openers')
            local is_dir = vim.fn.isdirectory(chosen_file) == 1
            if is_dir then
                require('yazi').yazi(config, chosen_file)
            else
                openers.open_file(chosen_file)
            end

        end
    },
}
