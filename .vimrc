set backspace=indent,eol,start
set ai
set et
set sts=2
set sta
set ts=2
" set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set history=50
set printoptions=paper:a4
set ruler
syntax enable
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim81,/usr/share/vim/vimfiles/after,/usr/share/vim/addons/after,/var/lib/vim/addons/after,~/.vim/after
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set shiftwidth=2
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" highlight text that is @ >80 chars
match ErrorMsg '\%>80v.\+'
let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
let php_folding=2
set foldmethod=syntax fdn=3
set foldlevel=1
" set foldcolumn=2
autocmd BufNewFile,BufRead Makefile
  \ setlocal expandtab!

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails.git'
Bundle 'fugitive.vim'
Bundle 'endwise.vim'
Bundle 'Tabular'
Bundle 'matchit.zip'
Bundle 'ack.vim'
Bundle 'kien/ctrlp.vim.git'
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'vesan/scss-syntax.vim.git'
Bundle 'python.vim'
Bundle 'tpope/vim-markdown'
Bundle 'timcharper/textile.vim'
Bundle 'nelstrom/vim-markdown-preview'
Bundle 'snipMate'
Bundle 'scrooloose/syntastic'
"Bundle 'SuperTab'

filetype plugin indent on
