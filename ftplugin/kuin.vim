" Vim filetype plugin
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2014/02/17 19:20:56.
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
setlocal isfname=a-z,A-Z,48-57
setlocal suffixesadd=.kn

" vim:ts=4:sts=4:sw=4:expandtab:ft=vim
