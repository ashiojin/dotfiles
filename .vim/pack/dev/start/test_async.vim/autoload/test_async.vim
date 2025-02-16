let s:sep = fnamemodify('.', ':p')[-1:]

let s:job_list = []

function! test_async#open(...) abort
    let cmd = join(a:000, ' ')
    let cmd = ["/usr/bin/sh", "-c", cmd]
    let job = job_start(cmd,
    \ {
    \   'out_cb': 's:cb_out',
    \   'err_cb': 's:cb_err',
    \   'exit_cb': 's:cb_exit',
    \ })

    let channel = job_getchannel(job)
    let ch_info = { 'id': v:none }
    if string(channel) isnot 'channel fail'
        let ch_info = channel->ch_info()
    endif
    let idx = s:job_list->len()
    let item = {
    \   'job': job,
    \   'ch_num': ch_info.id,
    \   'status': 'open',
    \   'out': [],
    \ }
    let s:job_list = s:job_list->add(item)

    return idx
endfunction

function! s:cb_out(ch, msg)
    "echom "On out_cb: " . a:ch . ", Message:`" . a:msg . "`"
    let ch_id = a:ch->ch_info().id
    for j in s:job_list
        if j.status is# 'open' && j.ch_num == ch_id
            let j.out = j.out->add(a:msg)
            break
        endif
    endfor
endfunction

function! s:cb_err(ch, msg)
    "echom "On err_cb: " . a:ch . ", Message:`" . a:msg . "`"
    let ch_id = a:ch->ch_info().id
    for j in s:job_list
        if j.status is# 'open' && j.ch_num == ch_id
            let j.out = j.out->add(a:msg)
            break
        endif
    endfor
endfunction

function! s:cb_exit(job, exit_status)
    "echom "On exit_cb: " . a:job . " ended with:" . a:exit_status
    let idx = 0
    for j in s:job_list
        if j.status is# 'open' && j.job->job_status() isnot 'run'
            let j.status = 'exited'
            echo '[Test Async] idx:' . idx . ' is ended with ' a:exit_status
            break
        endif
        let idx = idx + 1
    endfor
endfunction

function! test_async#stop() abort
    " let r = s:job->job_stop()
    " echom "Job stop: " . r
endfunction

function! test_async#info() abort
    echo "---"
    for j in s:job_list
        echo j
    endfor
endfunction

let s:buffer_name_header = '__TEST_ASYNC__@'
function! test_async#disp(idx) abort
    let bufname = s:buffer_name_header . a:idx
    " TODO: Only reopen the buffer if it already exists
    let buf_num = bufnr(bufname, 1)
    execute 'sbuffer' buf_num
    call setline(1, s:job_list[a:idx].out)
    call setbufvar(buf_num, '&modifiable', 0)
    call setbufvar(buf_num, '&buflisted', 0)
    set buftype=nofile
endfunction
