if exists('g:loaded_test_async')
    finish
endif
let g:loaded_test_async = 1


command! -nargs=* -complete=shellcmd TestAsync call test_async#open(<f-args>)
command! TestAsyncInfo call test_async#info()

