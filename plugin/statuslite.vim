" Location:     plugin/statuslite.vim
" Author:       thomasjlsn (https://github.com/thomasjlsn)
" Version:      0.2
" License:      Same as Vim itself.  See :help license
" ==========================================================================

scriptencoding utf-8

if exists('g:loaded_statuslite') || !has('statusline') || &compatible
  finish
endif
let g:loaded_statuslite = 1

if &laststatus !=# 2
  set laststatus=2
endif

if &t_Co !=# 256
  set t_Co=256
endif


" Colors ===================================================================

hi User1              cterm=bold   ctermfg=254  ctermbg=234
hi User2              cterm=none   ctermfg=254  ctermbg=237
hi User3              cterm=none   ctermfg=254  ctermbg=240
hi SLErrorColor       cterm=bold   ctermfg=232  ctermbg=1
hi SLGitBranchColor   cterm=bold   ctermfg=2    ctermbg=234
"  SLModifiedColor    defined in func `SLModified`
hi SLVirtualenvColor  cterm=bold   ctermfg=5    ctermbg=234


" Functions ================================================================

function! PlugExists(plug) abort
  " Check if a required plugin exists
  if (isdirectory(expand('~/.vim/bundle/'.a:plug.'/')) ||
      \ isdirectory(expand('~/.vim/plugged/'.a:plug.'/')))
    return 1
  endif
  return 0
endfunction

function! SLFileFormat() abort
  " Warn of undesirable file formats
  if &fileformat !=? 'unix'
    return '[ff='.&fileformat.']'
  else
    return ''
  endif
endfunction

function! SLFileEncoding() abort
  " Warn of undesirable file encodings
  if expand('%') ==? ''
    return ''  " Ignore unnamed files
  endif
  if &fileencoding !=? 'utf-8'
    return '[fenc='.&fileencoding.']'
  endif
  return ''
endfunction

function! SLGitBranch(branch) abort
  " Name of current git branch
  if a:branch !=? ''
    return a:branch.' '
  endif
  return ''
endfunction

function! SLModified() abort
  " Current file type, red if file is modified, ignores unnamed files
  if &modified
    hi SLModifiedColor   cterm=bold ctermfg=1   ctermbg=234
  else
    hi SLModifiedColor   cterm=bold ctermfg=254   ctermbg=234
  endif
  return ''
endfunction

function! SLVirtualenv() abort
  " Name of current virtual environment
  if exists('$VIRTUAL_ENV')
    let l:env=split(expand('$VIRTUAL_ENV'), '/')[-1]
    return l:env.' '
  endif
  return ''
endfunction


" Statusline ===============================================================

" Errors
set statusline=%#SLErrorColor#
set statusline+=%{SLFileFormat()}
set statusline+=%{SLFileEncoding()}
set statusline+=%r  " Readonly warning

" Cursor position
set statusline+=%1*\ ≡\ %l/%L       " Lines icon & line #/lines total
set statusline+=\:%v\               " Column #

" Environment info
if executable('virtualenv')
  set statusline+=%#SLVirtualenvColor#
  set statusline+=%{SLVirtualenv()}
endif
if executable('git') && PlugExists('vim-fugitive')
  set statusline+=%#SLGitBranchColor#
  set statusline+=%{SLGitBranch(fugitive#head())}
endif

" Filename
set statusline+=%2*\ %t\ %3*

" Split L & R
set statusline+=%=

" Filetype + modified indicator
set statusline+=%#SLModifiedColor#
set statusline+=%{SLModified()}%(\ %y\ %)
