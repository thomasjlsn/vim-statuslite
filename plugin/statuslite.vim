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
  hi User2 cterm=bold ctermfg=160 ctermbg=234
  hi User3 cterm=none ctermfg=254 ctermbg=237
  hi User4 cterm=none ctermfg=254 ctermbg=240
  hi User5 cterm=bold ctermfg=254 ctermbg=234

  function! GetMode()
    let s:currentmode = mode()

    hi User5 cterm=bold ctermfg=254 ctermbg=234
    let s:mode_name='NORMAL'

    if s:currentmode ==? 'r'
      hi User5 cterm=bold ctermfg=254 ctermbg=5
      let s:mode_name='REPLACE'
    elseif s:currentmode ==? 'v'
      hi User5 cterm=bold ctermfg=254 ctermbg=4
      let s:mode_name='VISUAL'
    elseif s:currentmode ==? 'i'
      hi User5 cterm=bold ctermfg=254 ctermbg=2
      let s:mode_name='INSERT'
    endif

    return s:mode_name
  endfunction

  " Always show the status line
  set laststatus=2

  set statusline=%5*\ %{GetMode()}\     " Mode indicator
  set statusline+=%1*%(\ ☰\ %)          " Lines icon
  set statusline+=%l/%L                 " Line #/lines
  set statusline+=\ \|                  " Seperator
  set statusline+=%(\ %v\ %)            " Column #
  set statusline+=%3*%(\ %t\ %)         " File name
  set statusline+=%4*%=                 " Split L & R
  set statusline+=%3*%(\ %{&ff}\ %)     " File format
  set statusline+=%3*%(%{&fenc}\ %)     " File encoding
  set statusline+=%2*%(\ %h%w%r%m%)%1*  " Flags
  set statusline+=%1*%(\ %y\ %)         " File type
endif
