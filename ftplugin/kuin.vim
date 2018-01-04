" Vim filetype plugin
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2018/01/04 15:21:17.
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
setlocal includeexpr=substitute(v:fname,'^',expand('%:r').'.','')

nnoremap <silent> <buffer> <C-k> :Kk<CR>

let s:script_dir = expand('<sfile>:p:h')
command! -nargs=* Kk :!Kk.bat %:p <args>
command! -nargs=* Kl :!kl.bat %:p <args>
command! -nargs=* Kw :!kw.bat %:p <args>
command! -nargs=* Kn :!kn.bat %:p <args>
command! -nargs=* Km :!km.bat %:p <args>

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
