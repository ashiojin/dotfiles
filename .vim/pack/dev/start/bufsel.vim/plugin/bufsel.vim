if exists('g:loaded_bufsel')
    finish
endif
let g:loaded_bufsel = 1


command! BufselOpen call bufsel#open_buflist()
