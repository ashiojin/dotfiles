return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
        ensure_installed = {
            "lua_ls", "rust_analyzer", "ts_ls", "volar", "clangd", "bashls",
        },
    },
}
