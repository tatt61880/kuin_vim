" Run from the repository root: vim -Nu NONE -i NONE -n -es -S test/indent.vim
set nocompatible
set runtimepath^=.
filetype plugin indent on
new example.kn
setlocal expandtab shiftwidth=0 tabstop=2

let expected = [
			\ 'func main()',
			\ '  if(true) { "}"',
			\ 'end func',
			\ '      { nested }',
			\ ' ; }',
			\ '}',
			\ '    do f("\{f("{")}")',
			\ '  { prefix } else',
			\ '    ret',
			\ '  end if',
			\ 'end func']
call setline(1, expected)
call setline(9, 'ret')
normal! gg=G
call assert_equal(expected, getline(1, '$'))

" Typing inside a comment must not insert an end statement.
call setline(3, 'if')
call cursor(3, 1)
call feedkeys("A(true)\<Esc>", 'xt')
call assert_equal('if(true)', getline(3))
call assert_equal('      { nested }', getline(4))

" An intervening comment may be outdented or contain a misleading end.
silent %delete _
call setline(1, ['if', '{', 'end for', '}', 'end if'])
call cursor(1, 1)
call feedkeys("A(true)\<Esc>", 'xt')
call assert_equal(['if(true)', '{', 'end for', '}', 'end if'], getline(1, '$'))

" Outside a comment, an unmatched header still gets a closing line.
silent %delete _
call setline(1, 'if')
call feedkeys("A(true)\<Esc>", 'xt')
call assert_equal(['if(true)', 'end if'], getline(1, '$'))

if !empty(v:errors)
	for error in v:errors
		echomsg error
	endfor
	cquit
endif
qa!
