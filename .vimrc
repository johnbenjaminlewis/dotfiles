
set nocompatible               " be iMproved
filetype off                   " required!


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" VUNDLE -- UrbanDictionary says it's a prime piece of real estate. Maybe they
"           were talking about the grundle.
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Let Vundle manage Vundle (required!)
Bundle 'gmarik/vundle'
helptags ~/.vim/bundle/vundle/doc	" load vundle help files

" Git
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'lukerandall/haskellmode-vim'
" Syntax checking
Bundle 'scrooloose/syntastic'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-airline/vim-airline-themes'
" Perl Syntax
Bundle 'vim-perl/vim-perl'
Bundle 'kien/rainbow_parentheses.vim'
" I can never get this to work right
Bundle 'wincent/Command-T'
" Extend `%` matching
" Bundle 'tmhedberg/matchit'
" Less syntax highlighting
Bundle 'groenewege/vim-less.git'
" Jinja syntax highlighting
"Bundle 'mitsuhiko/vim-jinja'
Bundle 'lepture/vim-jinja'
"Json syntax
Bundle 'elzr/vim-json'
" Bottom status bar
Bundle 'bling/vim-airline'
" Autocomplete
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/MatchTagAlways'
" extra js,html syntax highlighting
Bundle 'pangloss/vim-javascript'
Bundle 'embear/vim-localvimrc'
Bundle 'godlygeek/csapprox'

call vundle#end()
filetype plugin indent on     " required!


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Insert macros
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if !exists("*TimeStamp")
  fun TimeStamp()
    return "--BL (" . strftime("%d %b %Y %X") . ")"
  endfun
endif

iab JBL <C-R>=TimeStamp()<cr>

if !exists("*PythonEncoding")
  fun PythonEncoding()
    return "# -*- coding: utf-8 -*-"
  endfun
endif

iab PYENC <C-R>=PythonEncoding()<cr>


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Set Vim user enviroment
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set encoding=utf-8
nmap <C-k> :echo 'asdf'
let mapleader = ","
let maplocalleader = ";"
"screen scroles when cursor is within 5 lines of head or tail
set scrolloff=5

set autoindent
set smartindent
set copyindent

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set showbreak=↪
set splitbelow
set splitright
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set backspace=indent,eol,start

set nospell

set showcmd
set showmode
set autoread " Detect if file has changed. Not great outside of gvim
set cursorline
set cursorcolumn
set enc=utf-8
set number

" {{{ Completion
set completeopt=longest,menuone,preview
" To begin completion -> ^n
" To accept a match -> ^y
" To cancel -> ^e
" To move cursor -> ^n/^p
" Changing directory to match current buffer
cd %:p:h
" }}}

set autochdir
set foldmethod=marker

" {{{ Folding
nnoremap <Space> za
vnoremap <Space> za
" Make zO recursively open whatever top level fold we're in, no matter where
" the cursor happens to be.
nnoremap zO zCzO
" }}}

" Wildmenu completion {{{
set wildmenu
set wildmode=list,full
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

" Clojure/Leiningen
set wildignore+=classes
set wildignore+=lib
" }}}

syntax on
filetype on
filetype indent on
filetype plugin on
set copyindent
set preserveindent

set formatprg=par
" unwritten buffers will remain in the background
set hidden
" store temp files in home directory and expand file name with percent
" (indicated with // teminator)
set directory=$HOME/.vim/tmp//


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Remap
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Indent/unindent visual mode selection
map <tab>      >gv
vmap <S-tab>    <gv

" Correct word wrap behavior
noremap j gj
noremap k gk

" Easy split traversal
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
map <leader>q qg}

"redraw
nmap <leader>l :redraw! <CR>:echo 'Redrew window'<CR>


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Config plugins
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Colorscheme {{{
let g:zenburn_termcolors=256
let g:zenburn_transparent = 1
let g:zenburn_visibility=1
"let g:zenburn_high_Contrast=1
silent! colorscheme zenburn
" highlight Comment cterm=italic
" }}}

" Local vimrc {{{
let g:localvimrc_name='.benvimrc'
let g:localvimrc_persistent=1
" }}}

" Rainbowparens {{{
augroup Rainbow
  autocmd!
  autocmd VimEnter * RainbowParenthesesToggle
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
augroup END
"}}}

" Airline {{{
:set laststatus=2
let g:airline_theme = 'zenburn'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled =  1
" }}}


" Syntastic {{{
let g:syntastic_javascript_checkers = ['eslint']
" }}}

" Fugative {{{
augroup fugative
  autocmd!
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
" }}}


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Text specific

" Uglify text {{{
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$/
" }}}
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Language specific
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" C {{{

augroup ft_c
    autocmd!
    autocmd FileType c setlocal foldmethod=syntax
augroup END

" }}}

" Haskell {{{
augroup Haskell
  autocmd BufNewFile,BufRead *.hs set nospell
  autocmd BufEnter *.hs compiler ghc
augroup END
let g:haddock_browser = "/usr/bin/firefox"
let g:ghc = "/usr/bin/ghc"
" fetch latest haskellmode vimball from
" 'http://projects.haskell.org/haskellmode-vim/vimfiles/haskellmode-20090430.vba'
" to re-install, vim <file.vba>
"                :so %
" }}}

" Javascript {{{
augroup ft_javascript
  autocmd!
  autocmd FileType javascript setlocal foldmethod=marker
  autocmd FileType javascript setlocal foldmarker={,}
augroup END

" }}}

" Make {{{
augroup make
  autocmd!
  autocmd FileType make set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
augroup END
" }}}

" Perl {{{

" Perl Indent is severely fucked

augroup ft_perl
  autocmd!
  autocmd FileType perl set foldenable
  autocmd FileType perl set foldmethod=syntax
  autocmd FileType perl nnoremap <silent> _t :%!perltidy -q<Enter>
  autocmd FileType perl vnoremap <silent> _t :!perltidy -q<Enter>
  autocmd FileType perl set foldopen=block,hor,mark,percent,quickfix,tag
  autocmd FileType perl setlocal foldmethod=marker
  autocmd FileType perl setlocal foldmarker={,}
  " PerlTidy
  autocmd Syntax * :command! -range=% -nargs=* Tidy <line1>,<line2>! \perltidy <args>
  autocmd FileType perl setlocal keywordprg=perlfind
  autocmd FileType perl map <F3> :Tlist<CR>
augroup END
" taglist requires additional configuration for handling MOOSE
" http://stackoverflow.com/questions/2182164/is-there-a-vim-plugin-that-makes-moose-attributes-show-up-in-tag-list
let tlist_perl_settings='perl;u:use;p:package;r:role;e:extends;c:constant;a:attribute;s:subroutine;l:label'
let Tlist_Show_One_File = 1
" }}}

" Python shit {{{

let python_highlight_all=1
" BadWhitespace defined above

augroup python
  autocmd!
  autocmd BufNewFile,BufRead *.py set foldmethod=indent
  autocmd BufNewFile,BufRead *.py set foldlevel=99

  " Python Stuff
  " Display tabs at the beginning of a line in Python mode as bad.
  autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\t+/
  " " Make trailing whitespace be flagged as bad.
  autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s+$/
  autocmd BufNewFile,BufRead *.j2,*.jinja,*.jinja2 set filetype=jinja
  " uglify chars past the 79 col limit
  autocmd BufWinEnter *.py,*.pyw let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
augroup END
" }}}



"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vim Stuff
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Vim Stuff {{{
augroup VimWindow
  autocmd!
  " Resize splits when the window is resized
  autocmd VimResized * exe "normal! \<c-w>="
  " Automatically source the vimrc after it is written
  autocmd! bufwritepost ~/.vimrc source ~/.vimrc
  autocmd BufRead ~/.vimrc set foldlevel=0
augroup END

"delete the buffer; keep windows
function! Bk(kwbdStage)
if(a:kwbdStage == 1)
  let g:kwbdBufNum = bufnr("%")
  let g:kwbdWinNum = winnr()
  windo call Bk(2)
  execute "bd! " . g:kwbdBufNum
  execute "normal " . g:kwbdWinNum . ""
else
  if(bufnr("%") == g:kwbdBufNum)
    let prevbufvar = bufnr("#")
    if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != g:kwbdBufNum)
      b #
    else
      bn
    endif
  endif
endif
endfunction

map :bk :call Bk(1)

if &term == 'rxvt-unicode'
  set t_Co=256
elseif &term == 'screen'
  set t_Co=256
elseif &term == 'xterm-256color'
  set t_Co=256
endif
" }}}
