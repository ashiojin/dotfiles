return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            sync_install = false,
            ensure_installed = {
                "bash",

                "rust",
                "c",
                "lua",
                "html",

                "json",
                "toml",
                "yaml",

                "markdown",
                "markdown_inline",

                "diff",

                "regex",
                "vimdoc"
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
--    event = { "LazyFile", "VeryLazy" },

--    init = function(plugin)
--        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
--        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
--        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
--        -- Luckily, the only things that those plugins need are the custom queries, which we make available
--        -- during startup.
--        require("lazy.core.loader").add_to_rtp(plugin)
--        require("nvim-treesitter.query_predicates")
--    end,

--    opts_extend = { "ensure_installed" },
--    opts = {
--        highlight = { enable = true },
--        indent = { enable = true },
--
--        ensure_installed = {
--            "bash",
--
--            "rust",
--            "c",
--            "lua",
--            "html",
--
--            "json",
--            "toml",
--            "yaml",
--
--            "markdown"
--            "markdown_inline"
--            "diff",
--            "regex",
--            "vimdoc",
--        },
--    },
--
}
