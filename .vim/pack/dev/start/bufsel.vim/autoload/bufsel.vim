let s:sep = fnamemodify('.', ':p')[-1:]

let s:bufsel_list_buffer = '_BUFSEL_LIST_BUFFER_'

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
    " "bufsel#open_buflist()"

    let win_id_from = win_getid()
    if bufexists(s:bufsel_list_buffer)
        " Go to the buffer
        let winid = bufwinid(s:bufsel_list_buffer)
        let win_id_from = s:target_win_id
        if winid isnot# -1
            " "already exists & window opened " . s:bufsel_list_buffer
            call win_gotoid(winid)
        else
            " "already exists & window not-opened " . s:bufsel_list_buffer
            let bufnum = bufnr(s:bufsel_list_buffer)
            silent execute 'buffer' bufnum
        endif
    else
        " Create the buffer
        " "not-exists " . s:bufsel_list_buffer
        let buf_bufsel = bufnr(s:bufsel_list_buffer, 1)
        call setbufvar(buf_bufsel, '&buflisted', 0)
        call setbufvar(buf_bufsel, '&modifiable', 0)
        " " -> " . buf_bufsel
        silent execute 'sbuffer' buf_bufsel
        set buftype=nofile

        nnoremap <silent> <buffer> <Plug>(bufsel-close) :<C-u>call bufsel#close_buflist()<CR>
        nnoremap <silent> <buffer> <Plug>(bufsel-open-buf) :<C-u>call bufsel#open_buf(line('.')-1)<CR>
        nnoremap <silent> <buffer> <Plug>(bufsel-popup-buf-content) :<C-u>call bufsel#popup_buf_content(line('.')-1)<CR>
        nnoremap <silent> <buffer> <Plug>(bufsel-debug-item) :<C-u>call bufsel#debug_item(line('.')-1)<CR>

        nmap <buffer> q <Plug>(bufsel-close)
        nmap <buffer> <CR> <Plug>(bufsel-open-buf)
        nmap <buffer> <TAB> <Plug>(bufsel-popup-buf-content)
        nmap <buffer> ? <Plug>(bufsel-debug-item)

        augroup BufSelAugroup
            autocmd!
            autocmd CursorMoved <buffer> call bufsel#popup_buf_content(line('.')-1)
            autocmd BufLeave <buffer> call bufsel#popup_close()
        augroup END
    endif

    let buf_list = getbufinfo({'buflisted': 1})
    " If `buf_list` contains unloaded buffers, load the buffers first.
    let does_contain_unloaded = v:false
    for buf_item in buf_list
        if !buf_item.loaded
            let does_contain_unloaded = v:true
            silent! execute 'buffer' bufnr(buf_item.name)
        endif
    endfor
    if does_contain_unloaded
        silent! execute 'buffer' s:bufsel_list_buffer
        let buf_list = getbufinfo({'buflisted': 1})
    endif

    let buf_sel_list = map(copy(buf_list), {_key,val -> val.name})
    let buf_sel_list = bufsel#relative_path(buf_sel_list, getcwd())

    " Make list
    let buf_bufsel = bufnr(s:bufsel_list_buffer)
    " "buf:" . buf_bufsel . " " . s:bufsel_list_buffer
    call setbufvar(buf_bufsel, '&modifiable', 1)
    silent %delete _ " Delete all text
    call setline(1, buf_sel_list)
    call setbufvar(buf_bufsel, '&modifiable', 0)

    " Resize window
    let bufheight = line('$')
    let bufheight = bufheight >= 10 ? 10 : bufheight
    execute 'resize ' . bufheight

    " Store list to buffer
    let s:buf_list = buf_list
    let s:target_win_id = win_id_from
    call bufsel#popup_close()
    let s:popup_id = v:none
endfunction

function! bufsel#close_buflist() abort
    execute 'bwipeout!' s:bufsel_list_buffer
endfunction

function! bufsel#open_buf(idx) abort
    if bufexists(s:bufsel_list_buffer)
        execute 'buffer' s:bufsel_list_buffer
        let buf_item = s:buf_list->get(a:idx)
        if buf_item isnot# 0
            call win_gotoid(s:target_win_id)
            exec 'buffer' buf_item.name
            call bufsel#close_buflist()
        endif
    endif
endfunction

function! bufsel#popup_buf_content(idx) abort
    call bufsel#popup_close()

    if bufexists(s:bufsel_list_buffer)
        let buf_item = s:buf_list->get(a:idx)
        if buf_item isnot# 0
            let height = 30
            let top = buf_item.lnum - height/2 >= 1 ? buf_item.lnum - height/2 : 1
            let bottom = top + height -1

            if buf_item.loaded is# 0
                "silent! execute 'buffer' bufnr(buf_item.name)
                "silent! execute 'buffer' s:bufsel_list_buffer
                let lines = ["Not yet loaded"]
                let s:popup_id = popup_create(lines, { 'callback': 's:cb_popup_closed' })
            else
                let lines = getbufline(buf_item.name, top, bottom)
                let s:popup_id = popup_create(lines, { 'callback': 's:cb_popup_closed' })
            endif
        endif
    endif
endfunction

function! s:cb_popup_closed(id, result) abort
    " 'closed ' . s:popup_id
    let s:popup_id = v:none
endfunction

function! bufsel#popup_close() abort
    if exists('s:popup_id') && type(s:popup_id) isnot# v:t_none
        " 'closing ' . s:popup_id
        call popup_close(s:popup_id)
    endif
endfunction

function! bufsel#debug_item(idx) abort
    if bufexists(s:bufsel_list_buffer)
        let buf_item = s:buf_list->get(a:idx)
        " buf_item
    endif
endfunction
