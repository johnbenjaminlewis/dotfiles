augroup VimWindow
  autocmd!
  " Resize splits when the window is resized
  autocmd VimResized * exe "normal! \<c-w>="
  " Automatically source the vimrc after it is written
  autocmd! bufwritepost ~/.vimrc source ~/.vimrc
  autocmd BufRead ~/.vimrc set foldlevel=0
augroup END
