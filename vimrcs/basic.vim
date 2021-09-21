call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

if has("nvim")
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    " Plug 'nvim-lua/completion-nvim'

    " Neovim Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'

    " Telescope requirements...
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " StatusLine
    Plug 'hoob3rt/lualine.nvim'
else
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" TODO: prettier
Plug 'sbdchd/neoformat'
Plug 'ambv/black'

Plug 'tpope/vim-fugitive'

Plug 'vimwiki/vimwiki'

call plug#end()

filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

let mapleader = " " 

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Turn on the Wild menu
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=indent,eol,start

" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase

" Do not highlight search results.
set nohlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Use an old-school block curosr instead of thin cursor.
set guicursor=

set scrolloff=8

" Do not make annoying error sounds 
set noerrorbells

syntax enable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile
" Works great with undotree plugin
set undodir=~/.vim/undodir
set undofile 

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4

set autoindent "Auto indent
set smartindent "Smart indent
set wrap linebreak nolist "Wrap lines

set relativenumber

" Todo: This is remapped below. Use something different.
" map <leader>h :noh<CR>

colorscheme gruvbox
set background=dark

" Shortcuts to open project files, recent files, and comand history.
nnoremap <C-p> :Files<CR>
nnoremap <leader>ph :History<CR>
nnoremap <leader>ch :History:<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Resize windows
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
nnoremap <leader>tt :tab ba<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

if !has("nvim")
    " Format the status line
    set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO: Fix issue with gnome terminal interpreting Alt as Esc key
" Move a line of text using ALT+[jk] or Command+[jk] on mac
" noremap <Esc>j <M-j>
" nmap <M-j> mz:m+<cr>`z
" nmap <M-k> mz:m-2<cr>`z
" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Spelling errors are highlighted using the SpellBad highlighting group
hi clear SpellBad
hi SpellBad cterm=underline
" Set style for gvim
hi SpellBad gui=undercurl

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

set nocompatible
set showcmd
set number

imap jk <Esc>
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Delete selection to unnamed register and paste last in its place
vnoremap <leader>p "_dP

" Make Y yank till end of line to mirror behavior of D
nnoremap Y yg$

" Join lines and return cursor to initial location
nnoremap J mzJ`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

