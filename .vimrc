call pathogen#infect()

set nocompatible
filetype plugin on              " Recognize syntax by file extension.
syntax on                " Syntax highlighting.

augroup filetype javascript syntax=javascript

set path=.,,~/Code/**
" For `gf` jumps
set suffixesadd=.php,.js,.hbs,.go,.css,.less,.phtml,.ptxt,.vcl,.conf
set runtimepath^=~/.vim/bundle/ctrlp.vim
set rtp+=/usr/share/nvim/site/plugin/fzf.vim

set expandtab             " Expand tabs with spaces.
set ruler                 " Display row, column and % of document.
set shiftwidth=3          " >> and << shift 3 spaces.
set showmatch             " Show matching () {} etc..
set showmode              " Show current mode.
set softtabstop=3         " See spaces as tabs.
set tabstop=3             " <Tab> move three characters.

set number                " Display line numbers.
set relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting

syntax enable
" This should automatically be determined from the terminal type...
set t_Co=16

"Highlights lines that are greater than 80 columns
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength '\%80v.\+'
set colorcolumn=80

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" eslint stuff
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_javascript_eslint_exec = 'eslint_d'

let g:ale_linters = { 'php': ['php', 'psalm'] }
let g:ale_linters_explicit = 1

let g:terraform_align=1
let g:terraform_fmt_on_save=1

nnoremap <Leader>f :NERDTreeToggle<Enter>
let g:tagbar_phpctags_bin='/home/djmetzle/bin/phpctags'
nnoremap <Leader>w ::%s/\s\+$//e<CR>:nohl<CR>
nnoremap <Leader>s :Gstatus<CR>
nnoremap <Leader>d :Gvdiff<CR>
nnoremap <Leader>j :term<CR>ps -eaf<CR>
nnoremap <Leader>c :Gcommit -v<CR>
nnoremap <Leader>H ::nohl<CR>
nnoremap <Leader>z :FZF<CR>
nnoremap <Leader>2 :set tabstop=2<CR>:set softtabstop=2<CR>:set shiftwidth=2<CR>
nnoremap <Leader>3 :set tabstop=3<CR>:set softtabstop=3<CR>:set shiftwidth=3<CR>


nnoremap <Leader>S :set spell!<CR>

nmap <leader>p :exec prettier<CR>

" Toggle paste mode.
noremap <Leader>v :set paste!<CR>

nmap <leader>l :bnext<CR>
nmap <leader>h :bprev<CR>

" Nuke trailing whitespace
noremap <leader><Space> :%s/\s\+$//e<CR>:nohl<CR>
