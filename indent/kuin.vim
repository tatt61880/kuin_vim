" Vim indent file
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2017/12/18 01:57:14.
"
" Special Thanks:
"   http://labs.timedia.co.jp/2011/04/9-points-to-customize-automatic-indentation-in-vim.html
"
" == Usage ==
" Put this file into "indent" folder.

if exists('b:did_indent')
	finish
endif

" input [end if] automatically.
let b:kuin_auto_end = 1

setlocal indentexpr=GetKuinIndent()
setlocal indentkeys+=!^F,o,O,0=end,0=elif,0=else,0=case,0=default,0=catch,0=finally

if(b:kuin_auto_end == 1)
	inoremap <expr><silent><buffer> <space> AutoEnd(' ')
	inoremap <expr><silent><buffer> ( AutoEnd('(')
	inoremap <expr><silent><buffer> <cr> AutoEnd('<cr>')

	function! AutoEnd(c)
		let m = matchstr(getline('.'), '\v^\s*%(\zs%(if|switch|while|for|try|block)|\+?\*?\*?\zsfunc|\+?\zs%(class|enum))\ze>$')
		if(m != "")
			let line = line('.')
			let ind = indent(line)
			let nline = nextnonblank(line + 1)
			let nind = indent(nline)
			while(nline != 0 && ind < nind)
				let nline = nextnonblank(nline + 1)
				let nind = indent(nline)
			endwhile
			if(nline != 0 && ind == nind)
				if(matchstr(getline(nline), '\v^\s*end ' . m . '>') != "")
					return a:c
				endif
				if(m == 'if')
					if(matchstr(getline(nline), '\v^\s*%(else|elif)>') != "")
						return a:c
					endif
				elseif(m == 'switch')
					if(matchstr(getline(nline), '\v^\s*%(case|default)>') != "")
						return a:c
					endif
				elseif(m == 'try')
					if(matchstr(getline(nline), '\v^\s*%(catch|finally)>') != "")
						return a:c
					endif
				endif
			endif
			return "\<C-O>oend " . m . "\<C-O>k\<C-O>A" . a:c
		endif
		return a:c
	endfunction
endif

function! GetKuinIndent()
	let plnum = prevnonblank(v:lnum - 1)
	if plnum == 0
		return 0
	endif
	let ind = indent(plnum)
	if getline(plnum) =~# '\v^\s*%(if|elif|else|switch|case|default|while|for|try|catch|finally|block|\+?\*?\*?func|\+?class|\+?enum)>'
		let ind += &l:shiftwidth
	endif
	if getline(v:lnum) =~# '\v^\s*%(end|elif|else|case|default|catch|finally)>'
		let ind -= &l:shiftwidth
	endif
	return ind
endfunction

let b:did_indent = 1

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
