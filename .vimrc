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


" Toggle paste mode.
noremap <C-p> :set paste!<CR>

" Nuke trailing whitespace
noremap <C-\> :%s/\s\+$//e<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting

syntax enable
" This should automatically be determined from the terminal type...
set t_Co=16

"Highlights lines that are greater than 80 columns
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength '\%80v.\+'
set colorcolumn=80

set foldlevel=99

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

