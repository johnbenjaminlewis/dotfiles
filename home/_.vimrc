set nocompatible               " be iMproved

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/csapprox'
Plug 'flazz/vim-colorschemes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'embear/vim-localvimrc'
Plug 'alvan/vim-closetag'
Plug 'Valloric/MatchTagAlways'
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

""" {{{ Colors
if empty($VIM_FIRST_RUN)
    colorscheme badwolf
endif

set termguicolors

syntax enable

if &term == 'rxvt-unicode'
  set t_Co=256
elseif &term == 'screen'
  set t_Co=256
elseif &term == 'xterm-256color'
  set t_Co=256
endif
" }}}

""" {{{ Tabs and spacing
set expandtab                   " Enabling this will make the tab key (in insert mode) insert spaces
                                " instead of tab characters. This also affects the behavior of the retab command.
set shiftwidth=4                " The size of an "indent"
set softtabstop=4               " Setting this to a non-zero value other than tabstop will make
                                " the tab key (in insert mode) insert a combination of spaces
                                " (and possibly tabs) to simulate tab stops at this width.
set tabstop=4                   " For tab characters that appear 4-spaces-wide
" }}}

""" {{{ UI
filetype indent on              " Load filetype-specific indent files
filetype plugin on              " Defines autocommands that'll get executed when a file matching a
                                " given pattern is opened. These autocommands source in turn the
                                " filetype plugins associated to the filetype recognized.

set autochdir                   " Have Vim set PWD to file's directory
set autoread                    " Detect if file has changed (Not great outside of gvim)
set backspace=eol,indent,start  " Make backspace act like most other text editors
set cursorcolumn                " Highlight current column
set cursorline                  " Highlight current line
set directory=$HOME/.vim/tmp//  " store temp files in home directory and expand file name with percent
                                " (indicated with // teminator)
set foldmethod=marker           " Enable folding triggered by markers (the "{{{...}}}" things in your code)
set hidden                      " unwritten buffers will remain in the background
set lazyredraw                  " Redraw only when we need to (helps macros go faster)
set number                      " Show line numbers
set showbreak=↪                 " prepended to a breaking line
set showcmd                     " Show commmand at bottom
set showmatch                   " highlight matching [{()}]
set showmode                    " Show the current mode (visual, insert, exec, etc)
set signcolumn=yes              " always show signcolumns
set splitbelow                  " Horizontal splits go below current
set splitright                  " Vertical splits go right of current
set updatetime=300              " You will have bad experience for diagnostic messages when it's
                                " default 4000.
set wildmenu                    " Visual autocomplete for command menu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildmode=list,full


let mapleader = ","
let maplocalleader = ";"
" }}}

""" {{{ Search
set hlsearch                    " Highlight matches
set ignorecase                  " Ignore case when searching
set incsearch                   " Search as characters are entered
set smartcase                   " Searching for uppercase chars will make search case-sensitive
set wrapscan                    " Searching continues at end of file (wraps back to top)

vnoremap // y/<C-R>"<CR>        " Search for selected text in visual mode
" Turn off highlight
nnoremap <leader><space> :nohlsearch<CR>
" }}}

""" {{{ Remap keys

" {{{ Indent/unindent visual mode selection
map <tab>       >gv
vmap <S-tab>    <gv
" }}}

" {{{ Correct word wrap behavior
noremap j gj
noremap k gk
" }}}

" {{{ Easy split traversal
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
" }}}

" {{{ Redraw window
nmap <leader>l :redraw! <CR>:echo 'Redrew window'<CR>
" }}}

" {{{ Use space for folding
nnoremap <Space> za
vnoremap <Space> za
" Make zO recursively open whatever top level fold we're in, no matter where
" the cursor happens to be.
nnoremap zO zCzO
" }}}

" }}}

if empty($VIM_FIRST_RUN)
  for f in split(globpath('~/.vim/', '*.vim'), '\n')
    if filereadable(f)
      exec 'source' f
    endif
  endfor
endif

" Uglify text
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$/
