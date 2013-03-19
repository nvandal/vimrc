"Use vim-pathogen
runtime bundle/pathogen/autoload/pathogen.vim

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Prevent modeline security exploits
set modelines=0

"Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" *********************
" Better sane deafults
" *********************
set encoding=utf-8
set scrolloff=5
set showmode
set showcmd                      " display incomplete commands
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

" Change the leader key
let mapleader = ","

" Use ; instead of : (dont have to hold shift)
nnoremap ; :

" ****************
" Seaching/moving
" ****************

"Normal regex
nnoremap / /\v
vnoremap / /\v

"Intelligent case sensitive search
set ignorecase
set smartcase

"Global subsitution by default
set gdefault

"Highlight searches
set incsearch
set showmatch
set hlsearch

" Switch syntax highlighting on, when the terminal has colors Also switch on
" highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
syntax on
set hlsearch
endif


"Match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

"*******************
" History & Backups
"*******************
set nobackup	   " do not keep a backup file, use versions instead
set history=100	   " keep 50 lines of command line history

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" *****************
" Mouse interation
" *****************
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
set mouse=a
endif

" toggles the paste mode...avoid bad autoindents
set pastetoggle=<F2>

" **************
" autocommands
" **************

" Only do this part when compiled with support for autocommands.
if has("autocmd")

" Enable file type detection.  Use the default filetype settings, so that
" mail gets 'tw' set to 72, 'cindent' is on in C files, etc.  Also load
" indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx au!

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

augroup END

else

set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
\ | wincmd p | diffthis
endif

" ********************
" Leader key mappings
" ********************

"Toggle highlighting
function ToggleHLSearch()
       if &hls
            set nohls
       else
            set hls
       endif
endfunction
nnoremap <silent> <leader><space> <Esc>:call ToggleHLSearch()<CR>

"Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"Reselect text that was just pasted
nnoremap <leader>v V`]

"Create new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l

"Yankring show previously yanked text
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>
let g:yankring_history_file = '.yankring_history_file'

" Sudo write
cmap w!! %!sudo tee > /dev/null %

" ********************
" Enable vim-pathogen
" ********************
call pathogen#infect()
call pathogen#helptags()

" ********************
" Colorscheme
" ********************
 colorscheme default
