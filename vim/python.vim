augroup python
  autocmd!
  " Python Stuff
  " Display tabs at the beginning of a line in Python mode as bad.
  autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\t/
  " " Make trailing whitespace be flagged as bad.
  autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s+$/
  autocmd BufNewFile,BufRead *.j2,*.jinja,*.jinja2 set filetype=jinja
  " uglify chars past the col limit
  autocmd BufWinEnter *.py,*.pyw let w:m2=matchadd('ErrorMsg', '\%>119v.\+', -1)
augroup END
" }}}
