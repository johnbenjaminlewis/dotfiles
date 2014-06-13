set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
helptags ~/.vim/bundle/vundle/doc	"load vundle help files

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'scrooloose/syntastic'
Bundle 'Rykka/riv.vim'
Bundle 'flazz/vim-colorschemes'

Bundle 'scrooloose/nerdtree'
Bundle 'vim-perl/vim-perl'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/Jinja'

"Json syntax
Bundle 'elzr/vim-json'

" Bottom status bar
Bundle 'bling/vim-airline'

" autocomplete js
Bundle 'Valloric/YouCompleteMe'

" extra js,html syntax highlighting
Bundle 'pangloss/vim-javascript'

" Python autocomplete
"Bundle 'davidhalter/jedi-vim'
"
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'

" NON GITHUB REPOS
" ~~~~~~~~~~~~~~~~
Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
"Bundle 'file:///home/b/path/to/plugin'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"
"
" NerdTree
:map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * if (!argc()) | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == 'primary') | q | endif

"Comments
if !exists("*TimeStamp")
  fun TimeStamp()
    return "--BL (" . strftime("%d %b %Y %X") . ")"
  endfun
endif

iab JBL <C-R>=TimeStamp()<cr>

"=> Set Vim user enviroment 
let mapleader = ","
let maplocalleader = ";"
set scrolloff=5 "screen scroles when cursor is within 5 lines of head or tail
set expandtab "set space characters whenever tab is pressed
set autoindent  "G
set smartindent
set copyindent

let g:zenburn_termcolors=256
let g:zenburn_termtrans=1
let g:zenburn_visibility=1
let g:zenburn_high_Contrast=0
"set background=dark
colorscheme zenburn


set tabstop=2   
set shiftwidth=2
set softtabstop=2
set showbreak=↪ 
set splitbelow
set splitright
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
"
" Airline
:set laststatus=2
let g:airline_theme             = 'zenburn'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline#extensions#tabline#enabled =  1

set showcmd
set showmode
set autoread
set ruler
set cursorline
set cursorcolumn
set enc=utf-8

syntax on
filetype on
filetype indent on
filetype plugin on
set copyindent
set preserveindent

" Indent/unindent visual mode selection
vmap <tab>      >gv
vmap <S-tab>    <gv

set number

set backspace=indent,eol,start

" Perl {{{

" PerlTidy
au Syntax * :command! -range=% -nargs=* Tidy <line1>,<line2>! \perltidy <args>
" Perl Indent is severely fucked
"  mv /usr/share/vim/vim72/ftplugin/perl.vi{m,_}
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _t :!perltidy -q<Enter>

set foldenable
set foldmethod=syntax
set foldopen=block,hor,mark,percent,quickfix,tag

augroup ft_perl
  au!

  au FileType perl setlocal foldmethod=marker
  au FileType perl setlocal foldmarker={,}
  setlocal keywordprg=perlfind
augroup END

" }}}

" Javascript {{{

augroup ft_javascript
  au!

  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}
augroup END

" }}}

" C {{{

augroup ft_c
    au!
    au FileType c setlocal foldmethod=syntax
augroup END

" }}}
set foldmethod=marker
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
" Make zO recursively open whatever top level fold we're in, no matter where
" the cursor happens to be.
nnoremap zO zCzO
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

" Completion
set completeopt=longest,menuone,preview
" To begin completion
" ^n
" To accept a match
" ^y
" To cancel
" ^e
" To move cursor
" ^n/^p


" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Changing directory to match current buffer
set autochdir

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

" forgot to sudo? no worries
command! Wsudo :w !sudo tee >/dev/null %

set nospell
" run 'z=' to display misspelled words
" run '[s' to jump to previous misspelled word
" run ']s' to jump to next misspelled word
" run 'zG' to add word to good list
" run 'zW' to add word to bad list
" use lowercase to indicate temporary add


" Text objects:
" 'vip' to select a paragraph of text
" iW -- inner WORD (whitespace separated string of text, without whitespace)

set formatprg=par
" highlight text and run 'gq' to format some text

" run ':e.' to launch the file explorer
" run ':E.' to launch the file explorer in the last open buffer
" run ':Sex.' to launch the file explorer in the last open buffer in a split
" in explorer, run '%' to create a new file
" in explorer, run 'd' to create a new directory
"

" unwritten buffers will remain in the background
set hidden

if &term == 'rxvt-unicode'
  set t_Co=256
elseif &term == 'screen'
  set t_Co=256
elseif &term == 'xterm-256color'
  set t_Co=256
endif

" run ':changes' to list all changes
" run 'g;' to go to previous change
" run 'g,' to go to last change

autocmd BufNewFile,BufRead *.hs set nospell

" C-x,C-f when on a file path, enable autocomplete
" C-r C-w	Insert word under cursor in to text stream
" C-r /	  Insert last search string

" "+y copy text to clipboard
" "*y copy text to clipboard
" "+p paste text to clipboard
" "*p paste text to clipboard


" TO LIST THE LOADED SCRIPTS
" :scriptnames 

" Python Stuff
let python_highlight_all=1
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t+/
" " Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s+$/
au BufNewFile,BufRead *.j2 set filetype=jinja
" au BufWinEnter *.py,*.pyw set filetype=python

" uglify chars past the 80 col limit
au BufWinEnter *.py,*.pyw let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Haskell
au BufEnter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/firefox"
let g:ghc = "/usr/bin/ghc"
" fetch latest haskellmode vimball from
" 'http://projects.haskell.org/haskellmode-vim/vimfiles/haskellmode-20090430.vba' 
" to re-install, vim <file.vba>
"                :so %


" tslime is slime for vim using tmux
" C-c,C-c will send a buffer to the target
" use tab completion to select the instance, window and pane

" OrgMode Options
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
" Enable Template loading for org files
au BufReadPost,BufNewFile *.org TemplateLoad
au BufRead,BufNewFile *.org            call org#SetOrgFileType()
au BufRead *.org :PreLoadTags
au BufWrite *.org :PreWriteTags
au BufWritePost *.org :PostWriteTags
let g:org_command_for_emacsclient = 'emacsclient'
let g:agenda_files = ['~/notes/agenda.org', 'agenda.org']

let g:clang_use_snipmate=0

" taglist requires additional configuration for handling MOOSE
" http://stackoverflow.com/questions/2182164/is-there-a-vim-plugin-that-makes-moose-attributes-show-up-in-tag-list
let tlist_perl_settings='perl;u:use;p:package;r:role;e:extends;c:constant;a:attribute;s:subroutine;l:label'
let Tlist_Show_One_File = 1
map <F3> :Tlist<CR>

" FuzzyFinder makes browsing files easier
" Use tab to switch buffers
map <tab>j :FufBuffer<CR>
map <tab>k :FufFileWithFullCwd<CR>
" Use <C-n> or <C-p> to move up and down

" force writing a file when not sudo'ed
cmap w!! %!sudo tee > /dev/null %

" Find occurance of cursor text in includes
" [I

" Perform ex command on each matching line
" :g/PATTERN/COMMAND
" e.g.: find lines with match and delete
" :g/match/d
"
" Fun with matches:
" replace text beginning with 'for' with do
" s/\<for/do/

" store temp files in home directory and expand file name with percent
" (indicated with // teminator)
set directory=$HOME/.vim/tmp//

" Correct word wrap behavior
noremap j gj
noremap k gk
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" simulatd hex editor mode
" :%!xxd

" debug variable settings
" :verbose set makeprg?
"
" :perldo will execute each line in perl under the mutable value of $_
"
" observe command history
" q;
" use enter to execute command
"
" if already in ex mode
" <C-f>
"
" observe search history
" q/ or q?
"
" autocomplete an identical line of text
" ^X^L


" TagbarOpen



" Automatically source the vimrc after it is written
autocmd! bufwritepost ~/.vimrc source ~/.vimrc


" ConqueShell for Slime like features
" :ConqueTermSplit zsh
" ConqueTerm is an asshole and rebinds this key globally
let g:ConqueTerm_ToggleKey = '<F9>'

" Easymotion makes jumping in a screen easier
" \w -- selected letter
" Conflicts with command-t

" Marks
" [  start of last change
" ]  end of last change

" Yank-ring to simulate emac's kill ring
" <C-P> for older entries
" <C-N> for newer entries
" :YRShow
nnoremap <silent> <leader>p :YRShow<CR>

" Substitute
nnoremap <leader>s :%s//<left>

" VIMball with pathogen
" "
" mkdir ~/.vim/bundle/plugin-name
" vim <plugin-name.vba>
" :UseVimball <plugin-name.vba> ~/.vim/bundle/plugin-name

" Rainbow
"au Syntax * :call rainbow_parenthsis#Toggle()


map <leader>q qg}


