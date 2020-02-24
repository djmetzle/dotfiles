" Pathogen vim plugin loading - https://github.com/tpope/vim-pathogen
call pathogen#infect()

filetype on              " Recognize syntax by file extension.
syntax on                " Syntax highlighting.

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

nmap <leader>p :CtrlP<CR>

" Toggle paste mode.
noremap <Leader>v :set paste!<CR>

nmap <leader>l :bnext<CR>
nmap <leader>h :bprev<CR>

" Nuke trailing whitespace
noremap <leader><Space> :%s/\s\+$//e<CR>:nohl<CR>

