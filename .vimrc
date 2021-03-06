" Launch Config {{{
runtime! debian.vim
execute pathogen#infect()
filetype plugin indent on
set encoding=utf8
" }}}


" Colors {{{
let &t_AB="\e[48;5;%dm"
if !has('nvim')
  set term=xterm-256color
endif
set t_Co=256
let &t_AF="\e[38;5;%dm"
colorscheme onedark
syntax enable           " enable syntax processing
set t_ut=
" }}}


" Spaces & Tabs {{{
set tabstop=2           " 2 space tab
set expandtab           " use spaces for tabs
set softtabstop=2       " 2 space tab
set shiftwidth=2
set modelines=1
filetype indent on
filetype plugin on
set autoindent
if has('gui_running')
  "set guifont=Ubuntu_Mono:h11:cANSI
  set lines=50 columns=200
endif
set noeb vb t_vb=
" }}}


" UI Layout {{{
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline          " highlight current line
set wildmenu
set lazyredraw
set showmatch           " higlight matching parenthesis
set ruler
" }}}


" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
nnoremap <F3> :set hlsearch!<CR>
" }}}


" Jumping {{{
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

nnoremap <F2> :jumps<CR>
nnoremap <F4> :call GotoJump()<cr>
" }}}


" Misc {{{
map 0 ^ " Remap VIM 0 to first non-blank character

set relativenumber

cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
set ttyfast                     " faster redraw
" set backspace=indent,eol,start
set backspace=2

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

nnoremap <F1> :Startify<CR>
nnoremap <F6> :HackerNews<CR>
nnoremap <F7> :call ToggleNumber()<CR>
nnoremap <C-z> :term<CR>

nnoremap <C-J> m`o<Esc>``
nnoremap <C-K> m`O<Esc>``
" }}}


" Tab navigation {{{
nnoremap t0  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap t$  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
" }}}


" Leader Shortcuts {{{
let mapleader=","
nnoremap <leader>m :silent make\|redraw!\|cw<CR>
nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>1 :set number!<CR>
vnoremap <leader>y "+y
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
inoremap jk <esc>
inoremap <Char-0x07F> <BS>
nnoremap <Char-0x07F> <BS>
" nnoremap <leader>q :q<CR>
" nnoremap <leader><leader>qa :qa<CR>

nnoremap <leader>Gb :Gblame<CR>
nnoremap <leader>Gs :Gstatus<CR>
nnoremap <leader>Gd :Gdiff<CR>
" }}}


" Window resizing {{{
nnoremap <silent> <Leader>_ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>- :exe "vertical resize " . (winwidth(0) * 10/9)<CR>
nnoremap <silent> <Leader>= :exe "vertical resize " . (winwidth(0) * 9/10)<CR>
" }}}


" Powerline {{{
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
set laststatus=2
" }}}


" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|release/|venv/|node_modules/|bin/|obj/|\.git/|packages/|target/|\.(o|swp|pyc|egg|dll|pdb|jpg|gif|png|ico|)$'
" }}}


" NERDTree {{{
let NERDTreeIgnore = ['\.pyc$', 'build', 'venv', 'egg', 'egg-info/', 'dist', 'docs', 'release', 'node_modules', 'obj', 'bin', 'packages']
" }}}


" AutoGroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}


" Backups/swap/temp {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
set swapfile
set undodir=~/tmp
set dir=~/tmp
" }}}


" Custom Functions {{{
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        .numbe
    else
        set relativenumber
    endif
endfunction

function! RunTestsInFile()
    if(&ft=='php')
        :execute "!" . "/Users/dblack/pear/bin/phpunit -d memory_limit=512M -c /usr/local/twilio/src/php/tests/config.xml --bootstrap /usr/local/twilio/src/php/tests/bootstrap.php " . bufname('%') . ' \| grep -v Configuration \| egrep -v "^$" '
    elseif(&ft=='go')
        exec ":!gp test"
    elseif(&ft=='python')
        exec ":read !" . ". venv/bin/activate; nosetests " . bufname('%') . " --nocapture"
    endif
endfunction

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

function! <SID>CleanFile()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %!git stripspace
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
      let c = "("
  elseif c ==# "B"
      . .
  elsei c.r"
      let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction
" }}}


" EasyMotion stuff {{{
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

map <leader>J <Plug>(easymotion-jumptoanywhere)

map <Leader>w <Plug>(easymotion-bd-w)
map <Leader>W <Plug>(easymotion-bd-W)

map <Leader>e <Plug>(easymotion-bd-e)
map <Leader>E <Plug>(easymotion-bd-E)

map <Leader>ge <Plug>(easymotion-ge)
map <Leader>gE <Plug>(easymotion-gE)

map <Leader>T <Plug>(easymotion-bd-t)

map <Leader>l <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)

map <Leader>. <Plug>(easymotion-repeat)

map <Leader>s <Plug>(easymotion-s)
map <Leader>S <Plug>(easymotion-s2)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
" }}}


" Tagbar {{{
let g:tagbar_ctags_bin="ctags"
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_show_linenumbers=1
let g:tagbar_autopreview=1
let g:tagbar_autoclose=1
let g:tagbar_width=60
nmap <F12> :TagbarShowTag<CR>

let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\ }
" }}}


" CamelCaseMotion {{{
" map <silent> w <plug>camelcasemotion_w
" map <silent> b <plug>camelcasemotion_b
" map <silent> e <plug>camelcasemotion_e
" map <silent> ge <plug>camelcasemotion_ge
" sunmap w
" sunmap b
" sunmap e
" }}}


" vim-wheel {{{
let g:wheel#map#up   = '<c-k>'
let g:wheel#map#down = '<c-j>'
" }}}


" Selection search {{{
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
" }}}


" Line movement {{{
" Move a line of text using CTRL+[jk]
nmap <S-j> mz:m+<cr>`z
nmap <S-k> mz:m-2<cr>`z
vmap <S-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <S-k> :m'<-2<cr>`>my`<mzgv`yo`z
" }}}


" Syntastic {{{
nnoremap <Leader>sr :SyntasticReset<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}


" Autocomplete dialog {{{
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <C-j> pumvisible() ? '<C-n>' : ''
inoremap <expr> <C-k> pumvisible() ? '<C-P>' : ''
imap <expr> <C-l> pumvisible() ? '' : '<C-F><C-L>'
" }}}


" UndoTree {{{
nnoremap <F5> :UndotreeToggle<cr>
" }}}


" vim-bbyte {{{
nnoremap <Leader>q :Bdelete<CR>
nnoremap <Leader><Leader>q :bufdo :Bdelete<CR>
nnoremap <Leader>Q :q<CR>
" }}}


" vim-bookmarks {{{
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=238 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1

nnoremap ma :CtrlPBookmark<CR>
"}}}

" nerdcommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" }}}


" startify {{{
let g:startify_bookmarks = [
      \ { 'c': '~/.vimrc' },
      \ ]
let g:startify_transformations = [
      \ ['.*vimrc$', 'vimrc'],
      \ ]
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_enable_special = 0
let g:startify_files_number = 8
" }}}


" fzf {{{
nnoremap <C-[> :FZF<cr>
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
" }}}



unmap <esc>
