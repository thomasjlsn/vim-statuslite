" Location:     plugin/statuslite.vim
" Author:       thomasjlsn (https://github.com/thomasjlsn)
" Version:      0.1
" License:      Same as Vim itself.  See :help license

if exists('g:loaded_statuslite') || &cp
  finish
endif
let g:loaded_statuslite = 1

if has('statusline')
  if &t_Co !=# 256
    set t_Co=256
  endif

  hi User1 cterm=bold ctermfg=254   ctermbg=234
  hi User2 cterm=none ctermfg=254   ctermbg=237
  hi User3 cterm=none ctermfg=254   ctermbg=240
  hi User4 cterm=bold ctermfg=1     ctermbg=234
  hi User5 cterm=bold ctermfg=2     ctermbg=234
  hi User6 cterm=bold ctermfg=5     ctermbg=234
  hi User7 cterm=bold ctermfg=234   ctermbg=237
  hi User8 cterm=bold ctermfg=237   ctermbg=240

  " Always show the status line
  set laststatus=2

  set statusline=%1*\ ≡\ %l/%L      " Lines icon & line #/lines total
  set statusline+=\:%v\ %4*%(%r\ %) " Column # & readonly warning
  set statusline+=%7*%2*\ %t\      " File name
  set statusline+=%8*%3*
  if (isdirectory(expand('~/.vim/bundle/vim-fugitive/')) ||
      \ isdirectory(expand('~/.vim/plugged/vim-fugitive/')))
    set statusline+=\ %{FugitiveStatusline()}
  endif
  set statusline+=%=                " Split L & R
  set statusline+=%8*%2*\ %{&ff}\  " File format
  set statusline+=%{&fenc}\         " File encoding
  set statusline+=%7*%1*%(\ %6*%w%5*%h%4*%m%1*%y\ %) " Flags & file type
endif
