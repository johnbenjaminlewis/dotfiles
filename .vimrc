
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
" -------------------------
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'

" Haskell
Bundle 'neovimhaskell/haskell-vim'
Bundle 'Twinside/vim-hoogle'
Bundle 'nbouscal/vim-stylish-haskell'
Bundle 'edkolev/curry.vim'

" Themes/UI
" -------------------------
Bundle 'bling/vim-airline'
Bundle 'godlygeek/csapprox'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'kien/rainbow_parentheses.vim'

" Syntax highlighting
" -------------------------
Bundle 'groenewege/vim-less.git'
Bundle 'lepture/vim-jinja'
Bundle 'elzr/vim-json'

"Bundle 'pangloss/vim-javascript'
Bundle 'leafgarland/typescript-vim'
Bundle 'Quramy/tsuquyomi'
Bundle 'peitalin/vim-jsx-typescript'
"Bundle 'MaxMEllon/vim-jsx-pretty'
"Bundle 'HerringtonDarkholme/yats.vim'

Bundle 'embear/vim-localvimrc'
"yaml
Bundle 'hashivim/vim-terraform'
"nginx
Bundle 'chr4/nginx.vim'
Bundle 'alvan/vim-closetag'

" Syntax checking, completion and linting
" -------------------------
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'wincent/Command-T'
"Extend `%` matching
"Bundle 'tmhedberg/matchit'
Bundle 'Valloric/MatchTagAlways'

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

" Search for selected text in visual mode
vnoremap // y/<C-R>"<CR>

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
" Do we have ctags?
set tags=tags;/


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
" File explorer settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Close tag settings
" " filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

" Colorscheme {{{
set termguicolors
set background=dark
"let g:dracula_termcolors=256
"let g:dracula_transparent = 1
"let g:dracula_visibility=1
"let g:zenburn_high_Contrast=1
silent! colorscheme dracula
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
let g:syntastic_python_checkers = ['pycodestyle', 'pylint']
" }}}

" Fugative {{{
augroup fugative
  autocmd!
  autocmd User fugitive
    \ if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$' |
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
  autocmd!
  autocmd BufNewFile,BufRead *.hs set nospell
  autocmd BufEnter *.hs compiler ghc
  autocmd BufEnter *.hs echo "Haskell"
  autocmd FileType haskell let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
  autocmd FileType haskell let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
  autocmd FileType haskell let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
  autocmd FileType haskell let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
  autocmd FileType haskell let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
  autocmd FileType haskell let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
  autocmd FileType haskell let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

  autocmd FileType haskell let g:haskell_indent_if = 3
  autocmd FileType haskell let g:haskell_indent_case = 2
  autocmd FileType haskell let g:haskell_indent_let = 4
  autocmd FileType haskell let g:haskell_indent_where = 6
  autocmd FileType haskell let g:haskell_indent_before_where = 2
  autocmd FileType haskell let g:haskell_indent_after_bare_where = 2
  autocmd FileType haskell let g:haskell_indent_do = 3
  autocmd FileType haskell let g:haskell_indent_in = 1
  autocmd FileType haskell let g:haskell_indent_guard = 2
  autocmd FileType haskell let g:cabal_indent_section = 2


  autocmd FileType haskell " Syntastic help docs say tabstop=8
  autocmd FileType haskell set tabstop=8
augroup END
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
  autocmd FileType javascript set expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END
augroup ft_typescript
  autocmd!
  autocmd FileType typescript set expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType typescript.tsx  set expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END
augroup ft_json
  autocmd!
  autocmd FileType json setlocal foldmethod=marker
  autocmd FileType json setlocal foldmarker={,}
  autocmd FileType json set expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" }}}

" Make {{{
augroup make
  autocmd!
  autocmd FileType make set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
augroup END
" }}}

" yaml {{{
augroup yaml 
  autocmd!
  autocmd FileType yaml set expandtab tabstop=2 shiftwidth=2 softtabstop=2
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
