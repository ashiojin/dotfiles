return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",

        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                sync_install = false,
                ensure_installed = {
                    'bash',

                    'git_config',
                    'git_rebase',
                    'gitattributes',
                    'gitcommit',
                    'gitignore',

                    'rust',
                    'c',
                    'lua',

                    'html',
                    'css',

                    'typescript',
                    'javascript',
                    'vue',

                    'json',
                    'toml',
                    'yaml',

                    'markdown',
                    'markdown_inline',

                    'diff',

                    'regex',
                    'vimdoc',
                },
                highlight = { enable = true },
                indent = { enable = true },

                -- rrethy/nvim-treesitter-textsubjects
                textsubjects = {
                    enable = true,
                    prev_selection = '<A-.>',
                    keymaps = {
                        ['.'] = 'textsubjects-smart',
                        ['a.'] = {
                            'textsubjects-container-outer',
                            desc = 'select outer containers (classes, functions, etc.)'
                        },
                        ['i.'] = {
                            'textsubjects-container-inner',
                            desc = 'select inside containers (classes, functions, etc.)'
                        }
                    },
                }
            })
        end,


        dependencies = {
            'RRethy/nvim-treesitter-textsubjects'
        },
    },

}
