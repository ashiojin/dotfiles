return {
    'haya14busa/vim-asterisk',
    config = function ()
    end,
    init = function ()
        -- Choice "z" (stay) behavior as default
        vim.cmd([[
            map * <Plug>(asterisk-z*)
            map # <Plug>(asterisk-z#)
            map g* <Plug>(asterisk-gz*)
            map g# <Plug>(asterisk-gz#)
        ]])
    end,
}
