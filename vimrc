filetype on
filetype plugin on
filetype indent on

set nu
set ic nows
set shortmess+=A
set ai
set shortmess+=A
syntax off
set shiftwidth=4
set tabstop=4

augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
  autocmd BufNewFile,BufRead *.c++ set filetype=cpp
augroup END

autocmd FileType make setlocal noexpandtab

autocmd FileType human,cpp,c,py,go,hs setlocal expandtab

colorscheme desert

nnoremap <C-k> "=strftime("%d-%b-%Y\n===========\n")<CR>P
inoremap <C-k> <C-R>=strftime("%d-%b-%Y\n===========\n")<CR>
nnoremap <C-l> "=strftime("Pomodoro ==> %d-%b-%Y - %H:%M\n")<CR>P
inoremap <C-l> <C-R>=strftime("Pomodoro ==> %d-%b-%Y - %H:%M\n")<CR>
