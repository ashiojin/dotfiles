vim.cmd([[
" DELETE THIS
" --- set runtimepath^=~/.vim runtimepath+=~/.vim/after
" --- let &packpath = &runtimepath
" DELETE THIS

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

"colorscheme ron
"colorscheme vim
"set notermguicolors
]])

require("config.lazy")

vim.keymap.set('n', '<leader>q', function ()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win['quickfix'] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd([[cclose]])
    else
        if not vim.tbl_isempty(vim.fn.getqflist()) then
            vim.cmd([[copen]])
        else
            print('No quickfix list exists')
        end
    end
end, { desc = ':cwindow' })
