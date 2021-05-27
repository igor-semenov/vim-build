" File: hyperterm.vim
" Author: Igor Semenov
" Description: terminal color codes with location highlight

if exists("b:current_syntax")
  finish
endif

" Location - filename.ext:line or filename.ext:line:column
syntax match hypertermLocation /[a-zA-Z0-9\/\-_.]\+:\d\+\(:\d\+\)\=/

highlight vimbuildError              ctermfg=DarkRed     guifg=DarkRed       cterm=NONE          gui=NONE
highlight vimbuildWarn               ctermfg=Yellow      guifg=Yellow        cterm=NONE          gui=NONE
highlight vimbuildNote               ctermfg=Yellow      guifg=Yellow        cterm=NONE          gui=NONE
highlight vimbuildUnknown            ctermfg=DarkRed     guifg=DarkRed       cterm=NONE          gui=NONE

if has("conceal")
 syntax match hypertermAnsiConceal		contained conceal	"\e\[\(\d*;\)*\d*[A-Za-z]"
 syntax match hypertermAnsiSuppress		conceal			'\e\[[0-9;]*[A-Za-z]'
 syntax match hypertermAnsiSuppress		conceal			'\e\[?\d*[A-Za-z]'
 syntax match hypertermAnsiSuppress		conceal			'\b'
else
 syntax match hypertermAnsiConceal		contained		"\e\[\(\d*;\)*\d*[A-Za-z]"
 syntax match hypertermAnsiSuppress					'\e\[[0-9;]*[A-Za-z]'
 syntax match hypertermAnsiSuppress					'\e\[?\d*[A-Za-z]'
 syntax match hypertermAnsiSuppress					'\b'
endif

syntax region hypertermAnsiRed  		start="\e\[;\=0\{0,2};\=31m" skip='\e\[K' end="\e\["me=e-2 contains=hypertermAnsiConceal
syntax region hypertermAnsiGreen		start="\e\[;\=0\{0,2};\=32m" skip='\e\[K' end="\e\["me=e-2 contains=hypertermAnsiConceal
syntax region hypertermAnsiYellow		start="\e\[;\=0\{0,2};\=33m" skip='\e\[K' end="\e\["me=e-2 contains=hypertermAnsiConceal

highlight hypertermLocation           ctermfg=DarkCyan    guifg=DarkCyan      cterm=underline     gui=underline
highlight hypertermAnsiRed            ctermfg=DarkRed     guifg=DarkRed       cterm=NONE          gui=NONE
highlight hypertermAnsiYellow         ctermfg=DarkYellow  guifg=DarkYellow    cterm=NONE          gui=NONE
highlight hypertermAnsiGreen          ctermfg=DarkGreen   guifg=DarkGreen     cterm=NONE          gui=NONE
highlight def link hypertermAnsiSuppress	Ignore

