return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
        automatic_enable = {
            exclude = {
                "rust_analyzer"
            }
        },
        ensure_installed = {
            "lua_ls", "rust_analyzer", "ts_ls", "volar", "clangd", "bashls", "sqls"
        },
    },
}
