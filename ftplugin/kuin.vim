" Vim filetype plugin
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2017/04/15 23:14:05.
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
"setlocal path+=%UserProfile%/Documents/Kuin/sys/
setlocal path+=%UserProfile%/Documents/GitHub/Kuin-develop/package\sys/
setlocal isfname=a-z,A-Z,48-57
setlocal suffixesadd=.kn

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
