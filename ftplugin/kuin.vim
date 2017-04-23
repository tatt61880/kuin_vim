" Vim filetype plugin
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2017/04/24 02:58:17.
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
setlocal path+=%UserProfile%/Documents/GitHub/Kuin-develop/package/sys/
setlocal isfname=a-z,A-Z,48-57
setlocal suffixesadd=.kn

nnoremap <silent> <buffer> <C-k> :Ku<CR>

let s:script_dir = expand('<sfile>:p:h') 
command! -nargs=* Kc :!kuincl.bat -q -i % -e cui <args>
command! -nargs=* Kw :!kuincl.bat -q -i % -e wnd <args>
command! -nargs=* Ku :Kc && out.exe<CR>
command! -nargs=* Kn :Kw && out.exe<CR>

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
