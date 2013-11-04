" Vim filetype plugin
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2013/11/04 10:14:26.
"
" == Usage ==
" Put this file into "ftplugin" folder.

setlocal autoindent
setlocal noexpandtab
setlocal tabstop<
setlocal softtabstop=4
setlocal shiftwidth=4

"setlocal foldmethod=syntax

" For "gf" command.
setlocal path+=C:/PROGRA~1/Kuin/Std/ " "Program Files" isn't good (because ' ' included). Use 8dot3 name "PROGRA~1", instead.
setlocal isfname-=@-@
setlocal suffixesadd=.kn

" vim:ts=4:sts=4:sw=4:expandtab:ft=vim
