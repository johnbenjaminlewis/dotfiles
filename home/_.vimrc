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

""" {{{ Configure Plugins

" {{{ Airline
set laststatus=2
let g:airline_theme = 'badwolf'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled =  1
" }}}

" {{{ COC Code Completion
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:python3_host_prog = '~/.pyenv/shims/python'
let g:coc_global_extensions = ['coc-explorer', 'coc-json', 'coc-tsserver', 'coc-tslint-plugin', 'coc-highlight', 'coc-snippets', 'coc-template', 'coc-html', 'coc-css', 'coc-emmet', 'coc-python', 'coc-phpls', 'coc-angular', 'coc-git']

" }}}

" {{{ NETRW
" File explorer settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" }}}

" {{{ Rainbow Parans
if empty($VIM_FIRST_RUN)
    augroup Rainbow
      autocmd!
      autocmd VimEnter * RainbowParenthesesToggle
      autocmd Syntax * RainbowParenthesesLoadRound
      autocmd Syntax * RainbowParenthesesLoadSquare
      autocmd Syntax * RainbowParenthesesLoadBraces
    augroup END
endif
" }}}

""" }}}

""" {{{  Language/Filetype Specific

" {{{ All Text
" Uglify text
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$/
" }}}

" Vim Stuff {{{
augroup VimWindow
  autocmd!
  " Resize splits when the window is resized
  autocmd VimResized * exe "normal! \<c-w>="
  " Automatically source the vimrc after it is written
  autocmd! bufwritepost ~/.vimrc source ~/.vimrc
  autocmd BufRead ~/.vimrc set foldlevel=0
augroup END
" }}}

""" }}}
