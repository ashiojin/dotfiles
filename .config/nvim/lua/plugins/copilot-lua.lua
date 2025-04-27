return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        suggestion = {
            enabled = true,
            auto_trigger = false,
            hide_during_completion = true,
            debounce = 75,
            trigger_on_accept = true,
            keymap = {
                accept = "<C-]>",
                accept_word = "<C-f>",
                accept_line = "<C-F>",
                next = "<C-b>",
                prev = false,
                dismiss = "<C-_>",
            },
        },
    },
}
