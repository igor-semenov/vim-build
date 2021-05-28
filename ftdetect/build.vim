autocmd BufNewFile,BufRead * if expand('%') == g:build#LogPath | setfiletype hyperterm | endif
