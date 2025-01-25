"----------------------
"- Base settings
"----------------------
filetype plugin on
" Use vim in dark-background
set background=dark

syntax enable or syntax on

" Rectangular selection can go ahead even if no char is there.
set virtualedit=block

" Display line numbers
set number

" coc.nvim may give messages that need to take more than 1-line to display
set cmdheight=2

" Shorten CursorHold event occation timings to 300ms
" (Note: `updatetime` indicates idle time for writing Swap files)
set updatetime=300

" Can open another file, even if there are unsaved files. 
set hidden

" Enable mouse in all mode except invsert-mode (for right-click-paste)
set mouse=nvch

" Hilight matching pattern
set hlsearch

" Always show Sign-Column
set signcolumn=yes

" Show undisplayed chars
set list
set listchars=tab:≫_,trail:▯,nbsp:%,eol:↲,extends:⧛,precedes:⧚
"hi NonText ctermbg=None ctermfg=DarkGrey guibg=NONE guifg=NONE
"hi SpecialKey ctermbg=None ctermfg=Grey guibg=NONE guifg=NONE

" Vimdiff color-spec (disabled because of `background=dark`)
" highlight DiffAdd       cterm=bold  ctermbg=22
" highlight DiffDelete    cterm=bold  ctermbg=52
highlight DiffChange    ctermbg=53
highlight DiffText      cterm=bold  ctermbg=21

" Default settings about TAB
set expandtab
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Scroll
set scrolloff=1

" Status line
set laststatus=2
set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P

" Ex-mode completion
set wildmode=longest,list

"----------------------
"- Mapping
"----------------------
let mapleader="\<Space>"
" ---
"" Clear highlights on refresh
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" ---
"" Insert mode
cnoremap <C-a> <Home>
inoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-e> <End>

inoremap <silent> <C-b> <Cmd>normal! b<CR>
inoremap <silent> <C-f> <Cmd>normal! w<CR>


"----------------------
" Utilities for .vimrc
"----------------------
"" \brief Check if a plugin is installed.
"" \param[in] plugin Plugin name (directory name).
"" \return 1: installed, 0: not installed.
"" see https://senooken.jp/post/2018/01/24/
function! s:is_plugin_installed(plugin)
    return globpath(&runtimepath, 'pack/*/*/' . a:plugin, 1) != ''
endfunction

"----------------------
" File type
"----------------------
" file type initialze
augroup fileTypeIndent
    autocmd!
"    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
"    autocmd BufNewFile,BufRead *.htm setlocal tabstop=2 softtabstop=2 shiftwidth=2
"    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
"    autocmd BufNewFile,BufRead *.vue setlocal tabstop=2 softtabstop=2 shiftwidth=2
"    autocmd BufNewFile,BufRead *.js  setlocal tabstop=2 softtabstop=2 shiftwidth=2
"    autocmd BufNewFile,BufRead *.ts  setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
"autocmd BufRead,BufNewFile *.js setfiletype javascript
"autocmd BufRead,BufNewFile *.json setfiletype json

"----------------------
"- fern.vim
"----------------------
if s:is_plugin_installed('fern.vim')
    nnoremap <silent><leader>w :<C-u>Fern .<CR>

    function! s:init_fern() abort
        nmap <buffer> <leader>c <Plug>(fern-action-cd:cursor)
    endfunction

    augroup fern-custom
        autocmd! *
        autocmd FileType fern call s:init_fern()
    augroup END
endif " s:is_plugin_installed('fern.vim')



"----------------------
"- tussk : https://github.com/kawarimidoll/tuskk.vim.git
"----------------------
" 2024/06/24:カタカナ入力方法がわからん・・・辞書が必要なのかな・・・一旦使用停止
" if has ('nvim')
"     " TODO: And some functions/features are needed
"     inoremap <c-j> <cmd>call tuskk#toggle()<cr>
"     cnoremap <c-j> <cmd>call tuskk#cmd_buf()<cr>
" 
"     call tuskk#initialize({
"         \ 'jisyo_list':  [
"         \   { 'path': '~/.etc/dict/SKK-JISYO.L', 'encoding': 'euc-jp' },
"         \   { 'path': '~/.etc/dict/SKK-JISYO.emoji', 'mark': '[E]' },
"         \ ],
"         \ 'kana_table': tuskk#opts#builtin_kana_table(),
"         \ 'suggest_wait_ms': 200,
"         \ 'suggest_sort_by': 'length',
"         \ 'use_google_cgi' : v:true,
"         \ 'merge_tsu': v:true,
"         \ 'trailing_n': v:true,
"         \ })
" endif


"----------------------
"- coc.nvim
"----------------------
if s:is_plugin_installed('coc.nvim')
    let $NVIM_COC_LOG_LEVEL = 'trace'
    let g:coc_node_path = $NVM_BIN . '/node' " using nvm

    " See: :h coc-completion
    "
    " popup menu settings
    " In completion, don't select/insert automaticaly the option from the popup.
    set completeopt=menuone,noinsert

    " Use <CR> to confirm completion, use: >
    inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

    " insert <tab> when previous text is space, refresh completion if not.
    inoremap <silent><expr> <tab>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <sid>check_back_space() ? "\<tab>" :
      \ coc#refresh()
    inoremap <expr><s-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<c-h>"

    " s:check_back_space() (from coc.nvim .vimrc sample)
    "
    " Check if the character before the cursor is a space character,
    " or if the cursor is at the beginning of a line.
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1] =~# '\s'
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    "
    nmap <silent> <leader><leader> :<C-u>CocList<CR>

    xmap <leader>a <Plug>(coc-codeaction-selected)
    nmap <leader>a <Plug>(coc-codeaction-selected)

    nmap <leader>ac <Plug>(coc-codeaction-cursor)
    nmap <leader>as <Plug>(coc-codeaction-source)
    nmap <leader>af <Plug>(coc-fix-current)

    " nmap <silent> <leader>df <Plug>(coc-definision)
    nmap <leader>d <Plug>(coc-definition)
    nmap <leader>i <Plug>(coc-implementation)
    nmap <leader>r <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call ShowDocumentation()<CR>
    function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
        else
            call feedkeys('K', 'in')
        endif
    endfunction

    nnoremap <silent><nowait> <leader>D  :<C-u>CocList diagnostics<CR>
    nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<CR>
    nnoremap <silent><nowait> <leader>n  :<C-u>CocNext<CR>
    nnoremap <silent><nowait> <leader>N  :<C-u>CocPrev<CR>
    nnoremap <silent><nowait> <leader>R  :<C-u>CocListResume<CR>

    " Symbol renaming
    nmap <leader>R <Plug>(coc-rename)

    " formatting selected code
    xmap <leader>f <Plug>(coc-format-selected)
    nmap <leader>f <Plug>(coc-format-selected)

"    highlight CocFloating ctermbg=8

    " TODO:
    "  - code navigations
    "    <Plug>(coc-{-definision-|type-definition|implementation|references})
    "  - diagnostic
    "    <Plug>(coc-diagnostic-{prev|next})
    "  - 
endif " s:is_plugin_installed('coc.nvim')

if s:is_plugin_installed('bufsel.vim')
    nnoremap <silent><nowait> <leader>b :<C-u>BufselOpen<CR>
endif " s:is_plugin_installed('bufsel.vim')

"--------------------
"- .vimrc.local
"-  See https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
"--------------------
augroup vimrc-local
    autocmd!
    autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
    let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction
