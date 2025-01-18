let s:sep = fnamemodify('.', ':p')[-1:]

let s:bufsel_list_buffer = '[[BUFSEL_LIST_BUFFER]]'

function! bufsel#relative_path(names, dir) abort
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

function! bufsel#open_buflist() abort

    let win_id = win_getid()
    if bufexists(s:bufsel_list_buffer)
        " Go to the buffer
        let winid = bufwinid(s:bufsel_list_buffer)
        if winid isnot# -1
            call win_gotoid(winid)
        else
            execute 'sbuffer' s:bufsel_list_buffer
        endif
    else
        " Create the buffer
        let buf_bufsel = bufnr(s:bufsel_list_buffer, 1)
        call setbufvar(buf_bufsel, '&buflisted', 0)
        call setbufvar(buf_bufsel, '&modifiable', 0)
        silent execute 'sbuffer' buf_bufsel
        set buftype=nofile

        nnoremap <silent> <buffer> <Plug>(bufsel-close) :<C-u>call bufsel#close_buflist()<CR>
        nnoremap <silent> <buffer> <Plug>(bufsel-open-buf) :<C-u>call bufsel#open_buf(line('.')-1)<CR>

        nmap <buffer> q <Plug>(bufsel-close)
        nmap <buffer> <CR> <Plug>(bufsel-open-buf)
    endif

    let buf_list = getbufinfo({'buflisted': 1})
    let buf_sel_list = map(copy(buf_list), {_key,val -> val.name})
    let buf_sel_list = bufsel#relative_path(buf_sel_list, getcwd())

    " Make list
    let buf_bufsel = bufnr(s:bufsel_list_buffer)
    call setbufvar(buf_bufsel, '&modifiable', 1)
    %delete _ " Delete all text
    call setline(1, buf_sel_list)
    call setbufvar(buf_bufsel, '&modifiable', 0)

    " Store list to buffer
    let b:buf_list = buf_list
    let b:target_win_id = win_id
endfunction

function! bufsel#close_buflist() abort
    execute 'bwipeout!' s:bufsel_list_buffer
endfunction

function! bufsel#open_buf(idx) abort
    if bufexists(s:bufsel_list_buffer)
        execute 'sbuffer' s:bufsel_list_buffer
        let buf_item = b:buf_list->get(a:idx)
        if buf_item isnot# 0
            call win_gotoid(b:target_win_id)
            exec 'buffer' buf_item.name

            call bufsel#close_buflist()
        endif
    endif
endfunction
