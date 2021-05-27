" File: hyperterm.vim
" Author: Igor Semenov
" Description: hyperterm buffer specific code

setlocal autoread
setlocal colorcolumn=

if has("conceal")
  setlocal conceallevel=3 concealcursor=nv 
endif

" Parse location link
function! s:ParseLocation(log_str)
  let result = {}
  let m = matchlist(a:log_str, '\([a-zA-Z0-9./\-_]\+\):\([0-9]\+\):\(\([0-9]\+\):\)\=')
  if m != []
    let result = {
      \ 'filename': m[1],
      \ 'lnum': m[2],
      \ 'col': m[4]
    \ }
  endif 
  return result
endfunction


function! hyperterm#OpenLocation()
  let be = s:ParseLocation(getline('.'))
  if !empty(be)
    let fname = be['filename']
    if filereadable(fname)
      exe "edit" be['filename']
      call cursor(be['lnum'], be['col'])
    endif
  endif
endfunction

nnoremap <silent> <CR> :call hyperterm#OpenLocation()<CR>

