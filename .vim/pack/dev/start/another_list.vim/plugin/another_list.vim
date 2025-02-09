if exists('g:loaded_another_list')
    finish
endif
let g:loaded_another_list = 1


command! AnotherListOpen call another_list#open_buflist()
