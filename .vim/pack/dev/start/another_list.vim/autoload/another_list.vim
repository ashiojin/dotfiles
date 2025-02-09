let s:sep = fnamemodify('.', ':p')[-1:]

let s:another_list_list_buffer = '_ANOTHER_LIST_BUF_'

function! another_list#relative_path(names, dir) abort
    "# see: https://codeberg.org/scy/relatifile/src/branch/main/autoload/relatifile.vim
    let names = a:names
    let listarg = 1
    if type(a:names) ==# v:t_string
        let names = [a:names]
        let listarg = 0
    endif

    let cmd = 'realpath --relative-to ' . shellescape(a:dir)
    for name in names
        let cmd .= ' ' . shellescape(name)
    endfor
    silent let result = systemlist(cmd)
    if listarg
        return result
    else
        return result[0]
    endif
endfunction

function! another_list#open_buflist() abort
    "echom "another_list#open_buflist()"
    let win_id_from = win_getid()
    if bufexists(s:another_list_list_buffer)
        " Go to the buffer
        let bufnum = bufnr(s:another_list_list_buffer)
        let winid = bufwinid(s:another_list_list_buffer)
        let win_id_from = s:target_win_id
        if winid isnot# -1
            "echom "already exists & window opened " . s:another_list_list_buffer
            call win_gotoid(winid)
        else
            "echom "already exists & window not-opened " . s:another_list_list_buffer
            execute 'buffer' bufnum
        endif
    else
        " Create the buffer
        "echom "not-exists " . s:another_list_list_buffer
        let buf_another_list = bufnr(s:another_list_list_buffer, 1)
        call setbufvar(buf_another_list, '&buflisted', 0)
        call setbufvar(buf_another_list, '&modifiable', 0)
        "echom " -> " . buf_another_list
        silent execute 'sbuffer' buf_another_list
        set buftype=nofile

        nnoremap <silent> <buffer> <Plug>(another_list-close) :<C-u>call another_list#close_buflist()<CR>
        nnoremap <silent> <buffer> <Plug>(another_list-open-buf) :<C-u>call another_list#open_buf(line('.')-1)<CR>
        nnoremap <silent> <buffer> <Plug>(another_list-popup-buf-content) :<C-u>call another_list#popup_buf_content(line('.')-1)<CR>
        nnoremap <silent> <buffer> <Plug>(another_list-debug-item) :<C-u>call another_list#debug_item(line('.')-1)<CR>

        nmap <buffer> q <Plug>(another_list-close)
        nmap <buffer> <CR> <Plug>(another_list-open-buf)
        nmap <buffer> <TAB> <Plug>(another_list-popup-buf-content)
        nmap <buffer> ? <Plug>(another_list-debug-item)

        augroup AnotherListAugroup
            autocmd!
            autocmd CursorMoved <buffer> call another_list#popup_buf_content(line('.')-1)
            autocmd BufLeave <buffer> call another_list#popup_close()
        augroup END
    endif

    let list = ["I'm Another List.", "So, I'm not BufSel!", "OK?"]

    " Make list
    let buf_another_list = bufnr(s:another_list_list_buffer)
    "echom "an:" . buf_another_list . " " . s:another_list_list_buffer
    call setbufvar(buf_another_list, '&modifiable', 1)
    %delete _ " Delete all text
    call setline(1, list)
    call setbufvar(buf_another_list, '&modifiable', 0)

    " Resize window
    let bufheight = line('$')
    let bufheight = bufheight >= 10 ? 10 : bufheight
    execute 'resize ' . bufheight

    " Store list to buffer
    let s:buf_list = list
    let s:target_win_id = win_id_from
    call another_list#popup_close()
    let s:popup_id = v:none
endfunction

function! another_list#close_buflist() abort
    execute 'bwipeout!' s:another_list_list_buffer
endfunction

function! another_list#open_buf(idx) abort
    if bufexists(s:another_list_list_buffer)
        execute 'buffer' s:another_list_list_buffer
        let buf_item = s:buf_list->get(a:idx)
        if buf_item isnot# 0
            "echom buf_item
        endif
    endif
endfunction

function! another_list#popup_buf_content(idx) abort
    call another_list#popup_close()

    if bufexists(s:another_list_list_buffer)
        let buf_item = s:buf_list->get(a:idx)
        if buf_item isnot# 0

            let s:popup_id = popup_create(buf_item, { 'callback': 's:cb_popup_closed' })
        endif
    endif
endfunction

function! s:cb_popup_closed(id, result) abort
    "echom 'closed ' . s:popup_id
    let s:popup_id = v:none
endfunction

function! another_list#popup_close() abort
    if exists('s:popup_id') && type(s:popup_id) isnot# v:t_none
        "echom 'closing ' . s:popup_id
        call popup_close(s:popup_id)
    endif
endfunction

function! another_list#debug_item(idx) abort
    if bufexists(s:another_list_list_buffer)
        let buf_item = s:buf_list->get(a:idx)
        "echom buf_item
    endif
endfunction
