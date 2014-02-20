" Vim filetype plugin
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2014/02/20 22:19:06.
"
" == Usage ==
" Put this file into "ftplugin" folder.

if exists("b:did_ftplugin")
	finish
endif
"let b:did_ftplugin = 0

setlocal autoindent
setlocal noexpandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

"setlocal foldmethod=syntax

" For "gf" command.
setlocal path+=C:/PROGRA~1/Kuin/Std/ " "Program Files" isn't good (because ' ' included). Use 8dot3 name "PROGRA~1", instead.
setlocal isfname=a-z,A-Z,48-57
setlocal suffixesadd=.kn

" ku.exe ～
command! -nargs=* Ku execute '!start' 'ku.exe' '%' "<args>"
" ku.exe -e
command! -nargs=* Kue :Ku -e<CR>
" ku.exe -s
command! -nargs=* Kus :Ku -s<CR>

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
