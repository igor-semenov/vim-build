"
" Create new VIM buffer for exec results
" @param name - displayed buffer name
" @return created buffer number
"
function! s:NewScratchBuffer(name)
  let bnr = bufnr(a:name)
  if bnr != -1
    silent exe 'bdelete' bnr
  endif
  enew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setfiletype hyperterm
  silent exe 'file' a:name
  return bufnr('%')
endfunction

function! s:ExecOutCb(job, message) dict abort
  call appendbufline(self.buf, '$', a:message)
endfunction

"
" Exec command and output results in buffer
" @param buf_name - scratch buffer name
" @param argv - command to invoke
" @return job id
"
function! exec#AsyncCmd(buf_name, argv) abort
  let buf = s:NewScratchBuffer(a:buf_name)
  let options = {'buf': buf}
  call appendbufline(buf, 0, '> ' . join(a:argv, ' '))
  let b:job = job_start(a:argv, {
    \ 'out_cb': function('s:ExecOutCb', options),
    \ 'err_cb': function('s:ExecOutCb', options),
    \ 'pty': 1
  \ })
  autocmd BufUnload <buffer> if exists('b:job') | call job_stop(b:job) | endif
  return b:job
endfunction

