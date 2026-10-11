return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",

        opts = {
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

                'wgsl_bevy', -- TODO: When 'wesl' (or something similar) is available, switch to that
                'wgsl',

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
            highlight = {
                enable = true,
                disable = { 'rust' },
            },
            indent = {
                enable = true,
                disable = { 'rust' },
            },
            folds = {
                enable = true,
                disable = { 'rust' },
            },
        },

        config = function(_a, opts)
            local function printdbg(...)
                -- print(...)
            end
            printdbg('opts: ', vim.inspect(opts))
            --printdbg('a: ', vim.inspect(_a))
            local TS = require('nvim-treesitter')

            TS.setup(opts)

            TS.install(opts.ensure_installed)

            local function enabled_in_opts(feat, lang)
                if opts[feat] and opts[feat].enable then
                    if not opts[feat].disable then
                        return true
                    end
                    if type(opts[feat].disable) == 'table' then
                        for _, disabled_lang in ipairs(opts[feat].disable) do
                            if disabled_lang == lang then
                                printdbg('Feature ', feat, ' disabled for lang ', lang)
                                return false
                            end
                        end
                        return true
                    end
                end
                printdbg('Feature ', feat, ' not enabled in opts')
                printdbg(' - opts[feat]=', vim.inspect(opts[feat]))
                return false
            end


            -- Set FileType to start selected parsers
            local pattern = {}
            for _, lang in ipairs(opts.ensure_installed) do
                table.insert(pattern, lang)
            end
            printdbg('Setting up lazy treesitter parsers for fts=', vim.inspect(pattern))
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('lazy-treesitter-parsers', { clear = true }),
                pattern = pattern,
                callback = function(ev)

                    local enabled_str = ""
                    local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
                    if not lang then
                        printdbg('no lang for ft=', ft)
                        return
                    end

                    -- highlight
                    if enabled_in_opts('highlight', lang) then
                        vim.treesitter.start()
                        enabled_str = enabled_str .. " highlight"
                    end

                    -- indent
                    if enabled_in_opts('indent', lang) then
                        -- set indentexpr
                        vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
                        enabled_str = enabled_str .. " indent"
                    end


                    -- folds
                    if enabled_in_opts('folds', lang) then
                        -- set foldmethod
                        vim.wo.foldmethod = 'expr'
                        vim.wo.foldexpr = 'v:lua.require("nvim-treesitter").foldexpr()'
                        enabled_str = enabled_str .. " folds"
                    end

                    printdbg('Enabled treesitter for ft=', ft, ' lang=', lang, ' features:', enabled_str)
                end,
            })
        end,

        --         config = function()
        -- --            local configs = require("nvim-treesitter.configs")
        --
        --             return {
        --
        --                 -- rrethy/nvim-treesitter-textsubjects
        --                 -- textsubjects = {
        --                 --     enable = true,
        --                 --     prev_selection = '<A-.>',
        --                 --     keymaps = {
        --                 --         ['.'] = 'textsubjects-smart',
        --                 --         ['a.'] = {
        --                 --             'textsubjects-container-outer',
        --                 --             desc = 'select outer containers (classes, functions, etc.)'
        --                 --         },
        --                 --         ['i.'] = {
        --                 --             'textsubjects-container-inner',
        --                 --             desc = 'select inside containers (classes, functions, etc.)'
        --                 --         }
        --                 --     },
        --                 -- }
        --             }
        --         end,

        --         dependencies = {
        -- --            'RRethy/nvim-treesitter-textsubjects', -- ???
        --         },

    },

}
