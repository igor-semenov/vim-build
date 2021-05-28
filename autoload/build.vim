
if !exists('g:build#LogPath')
  let g:build#LogPath = '/tmp/vimbuild.log'
endif

function! s:BuildExitCb(job, status)
  unlet s:BuildJob
endfunction

function! s:UpdateLogBuffer()
  if exists('s:LogBuffer') && (s:LogBuffer == bufnr('%'))
    exe "checktime"
    normal! G
  endif
endfunction

function! s:BuildOutCb(channel, message)
  let log_path = g:build#LogPath
  call writefile([a:message], log_path, 'a')
  call s:UpdateLogBuffer()
endfunction

function! s:BuildErrCb(channel, message)
  let log_path = g:build#LogPath
  call writefile([a:message], log_path, 'as')
  call s:UpdateLogBuffer()
endfunction

"
" Exec command and output results in buffer
" @param argv - command to invoke
" @return job id
"
function! build#AsyncBuild(argv) abort
  let log_path = g:build#LogPath
  if !exists('s:BazelBuildJob')
    " Create or clear log file
    call writefile([], log_path, 'w')

    let s:BuildJob = job_start(a:argv, {
      \ 'out_cb': function('s:BuildOutCb'),
      \ 'err_cb': function('s:BuildErrCb'),
      \ 'exit_cb': function('s:BuildExitCb')
    \ })
  endif
  exe "view" log_path
  let s:LogBuffer = bufnr('%')
endfunction

