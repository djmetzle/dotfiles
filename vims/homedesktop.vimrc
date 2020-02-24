execute pathogen#infect()

syntax on
set nocompatible
filetype plugin indent on

set showmatch
set showcmd

" 4 character wide tabs
set expandtab
set tabstop=3
set shiftwidth=3

" Display line numbers.
set number
set relativenumber

set diffopt=vertical,filler,context:3

" Macro to switch line number modes based on edit mode
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" move around panes with <C-movement>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <Leader>s :Gstatus<CR>
nmap <leader>p :CtrlP<CR>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprev<CR>

nnoremap <Leader>z :FZF<CR>

" Toggle paste mode.
noremap <leader>v :set paste!<CR>

" Nuke trailing whitespace
noremap <leader><Space> :%s/\s\+$//e<CR>:nohl<CR>

let g:vimwiki_list = [{'path':'~/Work/vimwiki', 'path_html':'~/Work/vimwiki/html'}]

nnoremap <Leader>2 :set tabstop=2<CR>:set softtabstop=2<CR>:set shiftwidth=2<CR>
nnoremap <Leader>3 :set tabstop=3<CR>:set softtabstop=3<CR>:set shiftwidth=3<CR>

nmap <leader>c :e ~/.vimrc<CR>
