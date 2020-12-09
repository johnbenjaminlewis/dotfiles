let g:fzf_action = { 'enter': 'tabedit' }
nnoremap <leader>c :Commits<CR>
nnoremap <leader>h :FZF ~<CR>
nnoremap <leader>g :Ag<space>
nnoremap <expr> <leader>f (FugitiveHead() != '' ? ':GFiles --cached --others --exclude-standard<CR>' : ':Files<CR>')
nnoremap <leader>b :BCommits<CR>
