" Location:     plugin/statuslite.vim
" Author:       thomasjlsn (https://github.com/thomasjlsn)
" Version:      0.1
" License:      Same as Vim itself.  See :help license

if exists('g:loaded_statuslite') || &cp
  finish
endif
let g:loaded_statuslite = 1

if has('statusline')
  set t_Co=256

  hi User1 cterm=bold ctermfg=254 ctermbg=234
  hi User3 cterm=none ctermfg=254 ctermbg=237
  hi User4 cterm=none ctermfg=254 ctermbg=240
  hi User2 cterm=bold ctermfg=160 ctermbg=234

  " Always show the status line
  set laststatus=2

  set statusline=%1*%(\ %n\ %)         " Buffer #
  set statusline+=%2*%(%r%m\ %)%1*     " Flags
  set statusline+=%3*%(\ ☰\ %)         " 'Lines' icon
  set statusline+=%l/%L                " Line #/lines
  set statusline+=\ \|                 " Seperator
  set statusline+=%(\ %v\ %)           " Column #
  set statusline+=%4*%=                " Split L & R
  set statusline+=%3*%(\ %t\ %)        " File name
  set statusline+=%1*%(\ %y\ %)        " File type
endif
