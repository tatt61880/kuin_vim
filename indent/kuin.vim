" Vim indent file
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2026/11/06.
"
" Special Thanks:
"   http://labs.timedia.co.jp/2011/04/9-points-to-customize-automatic-indentation-in-vim.html
"
" == Usage ==
" Put this file into "indent" folder.

if exists('b:did_indent')
	finish
endif

let s:no_code = '\m^\s*\%(;\|$\)'

" Remove block comments when looking for indentation keywords. The stack
" also tracks quoted literals and embedded expressions, which can contain braces.
function! s:CodeOutsideComments(text, stack)
	let code = ''
	let start = get(a:stack, 0, '') ==# '}' ? -1 : 0
	let pos = 0
	while 1
		let context = get(a:stack, -1, '')
		let quoted = context ==# '"' || context ==# "'"
		if quoted
			let pos = match(a:text, '\m[' . context . '\\]', pos)
		else
			let pos = match(a:text, '\m[{};"'']', pos)
		endif
		if pos == -1
			break
		endif
		let char = a:text[pos]
		if quoted
			if char ==# context
				call remove(a:stack, -1)
			else
				let pos += 1
				if context ==# '"' && a:text[pos] ==# '{'
					call add(a:stack, '}')
				endif
			endif
		elseif char ==# ';'
			break
		elseif char ==# '{'
			if empty(a:stack)
				let code .= strpart(a:text, start, pos - start) . ' '
				let start = -1
			endif
			call add(a:stack, '}')
		elseif char ==# '}' && context ==# '}'
			call remove(a:stack, -1)
			if empty(a:stack)
				let start = pos + 1
			endif
		elseif char ==# '"' || char ==# "'"
			call add(a:stack, char)
		endif
		let pos += 1
	endwhile
	" An unfinished literal while typing must not hide the following lines.
	while !empty(a:stack) && a:stack[-1] !=# '}'
		call remove(a:stack, -1)
	endwhile
	return start == -1 ? code : code . strpart(a:text, start)
endfunction

function! s:LineInfo(lnum)
	if !exists('b:kuin_comments') || b:kuin_comments.tick != b:changedtick
		let b:kuin_comments = {'tick': b:changedtick, 'through': 0, 'stack': [], 'lines': {}}
	endif
	let cache = b:kuin_comments
	if a:lnum > cache.through
		let lines = getline(cache.through + 1, a:lnum)
		let i = 0
		while i < len(lines)
			let inside = get(cache.stack, 0, '') ==# '}'
			if empty(cache.stack)
				" Skip whole runs of ordinary code without scanning them in Vimscript.
				let i = match(lines, '{', i)
				if i < 0
					break
				endif
			endif
			let code = s:CodeOutsideComments(lines[i], cache.stack)
			if inside || code !=# lines[i]
				let cache.lines[cache.through + i + 1] = {'code': code, 'inside': inside}
			endif
			let i += 1
		endwhile
		let cache.through = a:lnum
	endif
	return get(cache.lines, a:lnum, {'code': getline(a:lnum), 'inside': 0})
endfunction

" input [end if] automatically.
let b:kuin_auto_end = 1

setlocal indentexpr=GetKuinIndent()
setlocal indentkeys+=!^F,o,O,0=end,0=elif,0=else,0=case,0=default,0=catch,0=finally

if(b:kuin_auto_end == 1)
	inoremap <expr><silent><buffer> <space> AutoEnd(' ')
	inoremap <expr><silent><buffer> ( AutoEnd('(')
	inoremap <expr><silent><buffer> <cr> AutoEnd('<cr>')

	function! AutoEnd(c)
		let m = matchstr(getline('.'), '\v^\s*%(\zs%(if|switch|while|for|try|block)|\+?\*?\*?\zsfunc|\+?\zs%(class|enum))\ze>')
		if(m != "" && !s:LineInfo(line('.')).inside)
			let before_cursor = strpart(getline('.'), 0, col('.') - 1)
			if before_cursor =~# '{'
				let stack = []
				call s:CodeOutsideComments(before_cursor, stack)
				if get(stack, 0, '') ==# '}'
					return a:c
				endif
			endif
			let line = line('.')
			let ind = indent(line)
			let nline = nextnonblank(line + 1)
			while nline != 0
				let next_code = s:LineInfo(nline).code
				if next_code !~# s:no_code && indent(nline) <= ind
					break
				endif
				let nline = nextnonblank(nline + 1)
			endwhile
			if(nline != 0 && ind == indent(nline))
				if(matchstr(next_code, '\v^\s*end\s+' . m . '>') != "")
					return a:c
				endif
				if(m == 'if')
					if(matchstr(next_code, '\v^\s*%(else|elif)>') != "")
						return a:c
					endif
				elseif(m == 'switch')
					if(matchstr(next_code, '\v^\s*%(case|default)>') != "")
						return a:c
					endif
				elseif(m == 'try')
					if(matchstr(next_code, '\v^\s*%(catch|finally)>') != "")
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
	let current = s:LineInfo(v:lnum)
	if current.inside && current.code =~# s:no_code
		return -1
	endif
	let plnum = prevnonblank(v:lnum - 1)
	while plnum > 0
		let previous = s:LineInfo(plnum)
		" Comment opening lines get normal indentation and can anchor the next line.
		if !previous.inside || previous.code !~# s:no_code
			break
		endif
		let plnum = prevnonblank(plnum - 1)
	endwhile
	if plnum == 0
		return 0
	endif
	let ind = indent(plnum)
	if previous.code =~# '\v^\s*%(if|elif|else|switch|case|default|while|for|try|catch|finally|block|\+?\*?\*?func|\+?class|\+?enum)>'
		let ind += shiftwidth()
	endif
	if current.code =~# '\v^\s*%(end|elif|else|case|default|catch|finally)>'
		let ind -= shiftwidth()
	endif
	return ind
endfunction

let b:did_indent = 1

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
