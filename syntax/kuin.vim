" Vim syntax file
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2017/01/04 05:34:54.
"
" == Usage ==
" Put this file into "syntax" folder.

if exists("b:current_syntax")
    finish
endif

syntax case match

"処理重い...
"syn match	kuinDoLessError	/\v%(^\s*)@<=\S+/ " for forgetting 'do'
syn match	kuinSpecial	/#/
syn match	kuinSpecial	/@/

" *Comment {{{1
syn region	kuinBlockComment contains=kuinBlockComment,kuinString,kuinCharacter,kuinTodo
			\ start='{'
			\ end='}'
			\ fold
" }}}1
" *Constant {{{1
syn keyword	kuinConstant null inf
syn region	kuinString contains=kuinCharacterError
			\ start=/"/
			\ end=/"\|$/
			\ skip=/\v%(\\)@<!%(\\\\)*\\"/
syn match	kuinCharacter	/'[^\']'/
syn match	kuinCharacter	/'\\.'/	contains=kuinCharacterError
"syn match	kuinCharacterError	/\v%(%(\\)@<!\\%(\\\\)*)@<!\\0/	contained " \0 isn't arrowed

" kuinNumber {{{2
syn match	kuinError	/\v<\d\w+>/		" e.g. 1000_000 => Error, 100yen => Error
syn match	kuinNumber	/\v<\d+b%(8|16|32|64)>/
syn match	kuinNumber	/\v<0%(\.\d+)=>/
syn match	kuinNumber	/\v<[1-9]\d*%(\.\d+)=>/
syn match	kuinError	/\v<10#/		" e.g.  10#9999 => Error
syn match	kuinError	/\v<\d+#\w+>/	" e.g. 100#FFFF => Error, 8#8888 => Error
syn match	kuinNumber	/\v<2#[0-1]+%(\.[0-1]+)=>/
syn match	kuinNumber	/\v<8#[0-7]+%(\.[0-7]+)=>/
syn match	kuinNumber	/\v<16#[0-9A-F]+%(\.[1-9A-F]+)=>/
" }}}2
syn keyword	kuinBoolean	true false
" }}}1
" *Identifier {{{1
" kuinIdentifierは不要？
"syn match	kuinIdentifier	/\<\h\w*\>/ transparent
syn match	kuinKeyword		/\v%(^\s*)@<!<me>/
syn keyword	kuinFunction	main
"syn keyword	kuinFunction	init main
"syn keyword	kuinNamespace	kuin cui lib
"syn match	kuinFunction	"\v<%(kuin\@)@<=stop>"
"syn match	kuinFunction	"\v<%(kuin\@)@<=act>"
"syn keyword	kuinFunction	ToStr Len Copy
"syn keyword	kuinFunction	Ctor Dtor
" }}}1
" *Statement {{{1
syn keyword	kuinStatement	skip var break ret assert
syn keyword	kuinDoStatement	do
syn region	kuinBlock contains=ALLBUT,kuinClassError
			\ matchgroup=kuinStatement
			\ start=/\v%(^\s*\-?\s*\+?\s*)@<=<func>/
			\ end=/\v%(^\s*)@<=<end\s+func>/
			\ fold
syn region	kuinBlock contains=ALLBUT,kuinClassError
			\ matchgroup=kuinStatement
			\ start=/\v%(^\s*)@<=<block>/
			\ end=/\v%(^\s*)@<=<end\s+block>/
			\ fold
syn keyword	kuinConditional else elif
syn region	kuinBlock contains=ALLBUT,kuinClassError
			\ matchgroup=kuinConditional
			\ start=/\v%(^\s*)@<=<\z(if|switch)>/
			\ end=/\v%(^\s*)@<=<end\s+\z1>/
			\ fold
syn region	kuinBlock contains=ALLBUT,kuinClassError
			\ matchgroup=kuinRepeat
			\ start=/\v%(^\s*)@<=<\z(while|for|foreach)>/
			\ end=/\v%(^\s*)@<=<end\s+\z1>/
			\ fold
syn keyword	kuinLabel case default
syn match	kuinError		"\v%(^\s*var\s+\w+\s*:\s*%(\[\])*\w+)@<=\s*::.*" " In global scope, [var VName: type ::] isn't arrowed.
syn match	kuinOperator	"\v\s*\:%(:|\+|\-|\*|\/|\%|\^|\~|\$)" contained " ::
syn match	kuinOperator	"\~"	contained
syn match	kuinOperator	"=&"	contained
syn match	kuinOperator	"=$"	contained
syn match	kuinOperator	"+"		contained
syn match	kuinOperator	"-"		contained
syn match	kuinOperator	"*"		contained
syn match	kuinOperator	"/"		contained
syn match	kuinOperator	"%"		contained
syn match	kuinOperator	"\^"	contained
syn match	kuinOperator	"!"		contained
syn match	kuinClassError	"\v%(^\s*var\s+\w+\s*:\s*%(\[\])*\w+)@<=\s*::.*" contained " In global scope, [var VName: type ::] isn't arrowed.
syn match	kuinOperator	"\v\?%(\()@="
syn match	kuinError		/\v%(\?)@<=\s+%(\()@=/ contained " [? ( is not arrowed. It should be ?(]
syn match	kuinOperator	"#"
syn match	kuinOperator	/\v\=/
syn match	kuinError		/\v\={2,}/	" Use =    instead of ==
syn match	kuinError		/;/
syn match	kuinError		/\v%(<do\s+\w+%(\[\d+\])*\s*:)@<=\s+/	" [do VName : ] isn't correct sentence.
syn match	kuinError		/\v%(<do\s+\w+%(\[\d+\])*\s*)@<=\=/		" [do VName =] isn't correct sentence.
syn match	kuinError		/\v%(<var\s+\w+\s*:\s*%(\[\])*\w+\s*)@<=\=/	" [var VName : Type =] isn't correct sentence.
syn match	kuinError		/\v%(<var\s+\w+\s*)@<=::/	" [var VName ::] isn't correct sentence.
"syn match	kuinError		/\v%(:)@<=\s+%(:)@=/	" [: :] isn't arrowed.
syn match	kuinOperator	/\v\<\>/
syn match	kuinError		/\v!\=/			" Use <>   instead of !=
syn match	kuinOperator	/\v\&/
syn match	kuinError		/\v\&{2,}/		" Use &    instead of &&
syn match	kuinOperator	/\v\|/
syn match	kuinError		/\v\|{2,}/		" Use |    instead of ||
syn match	kuinError		/\v\+{2,}/		" Use :+ 1 instead of ++
syn match	kuinError		/\v\-{2,}/		" Use :- 1 instead of --
syn match	kuinOperator	/\v(\<|\>)\=?/	" <, >, <=, >=
syn match	kuinError		/\v%([\>=])@<=\s+%(\&)@=/ contained " [<> & is not arrowed. It should be <>&]
syn match	kuinError		/\v%(\<)@<=\s+%(\>)@=/ contained " [< > is not arrowed. It should be <>]
syn match	kuinOperator	/\v\$/			" $ (cast operator)
"処理重い...
"syn match	kuinError	/\v%(^\s*)@<=[<>\~\=\*/%&\|\^0-9]/	contained " [Some kind of character '*' etc. doesn't come at line head.]
syn keyword	kuinException throw catch finally
syn region	kuinBlock contains=ALLBUT,kuinClassError
			\ matchgroup=kuinException
			\ start=/\v%(^\s*)@<=<try>/
			\ end=/\v%(^\s*)@<=<end\s+try>/
			\ fold
" }}}1
" *PreProc {{{1
syn keyword	kuinPreCondit dbg rls
syn region	kuinBlock contains=ALLBUT,kuinClassError
			\ matchgroup=kuinPreCondit
			\ start=/\v%(^\s*)@<=<ifdef>/
			\ end=/\v%(^\s*)@<=<end\s+ifdef>/
			\ fold
" }}}1
" *Type {{{1
syn keyword	kuinType	int float char bool list stack queue dict
syn match	kuinType	"\v%(^\s*\-?\s*\+?\s*)@<!<func>"
syn keyword	kuinType	bit8 bit16 bit32 bit64
syn keyword	kuinStorageClass	const
syn region	kuinBlock contains=ALLBUT,kuinDoLessError
			\ matchgroup=kuinStructure
			\ start=/\v%(^\s*-?\s*)@<=<enum>/
			\ end=/\v%(^\s*)@<=<end\s+enum>/
			\ fold
syn region  kuinBlock contains=ALLBUT,kuinDoStatement
			\ matchgroup=kuinStructure
			\ start=/\v%(^\s*-?\s*)@<=<class>/
			\ end=/\v%(^\s*)@<=<end\s+class>/
			\ fold
" }}}1
" *Todo {{{1
syn keyword	kuinTodo contained TODO FIXME XXX
syn match	kuinTodo contained "\v%(\s|\{)@<=☆%(\s|\})@="
" }}}1

" def link {{{1
" *Comment
hi def link kuinBlockComment	Comment
" *Constant
hi def link kuinConstant		Constant
hi def link kuinString			String
hi def link kuinCharacter		Character
hi def link kuinNumber			Number
hi def link kuinBoolean			Boolean
" *Identifier
hi def link kuinIdentifier		Identifier
hi def link kuinFunction		Function
" *Statement
hi def link kuinStatement		Statement
hi def link kuinDoStatement		Statement
hi def link kuinConditional		Conditional
hi def link kuinRepeat			Repeat
hi def link kuinLabel			Label
hi def link kuinOperator		Operator
hi def link kuinKeyword			Keyword
hi def link kuinException		Exception
" *PreProc
hi def link kuinPreCondit		PreCondit
" *Type
hi def link kuinType			Type
hi def link kuinStorageClass	StorageClass
hi def link kuinStructure		Structure
" *Special
hi def link kuinSpecial			Special
" *Error
hi def link kuinError			Error
hi def link kuinCharacterError	Error
hi def link kuinClassError		Error
hi def link kuinDoLessError		Error
" *Todo
hi def link kuinTodo			Todo
" }}}1

let b:current_syntax = "kuin"
syn sync fromstart

" Setting for matchit.vim
" http://www.vim.org/scripts/script.php?script_id=39
let s:matchpairs_func	= '\%(\%(\w\|\:\)\s\+\)\@\<\!\<func\>:' . '\<end\s\+func\>'
let s:matchpairs_if		= '\%(\<end\s\+\)\@\<\!\<if\>:'		. '\<elif\>:'	. '\<else\>:'		. '\<end\s\+if\>'
let s:matchpairs_switch	= '\%(\<end\s\+\)\@\<\!\<switch\>:'	. '\<case\>:'	. '\<default\>:'	. '\<end\s\+switch\>'
let s:matchpairs_try	= '\%(\<end\s\+\)\@\<\!\<try\>:'	. '\<catch\>:'	. '\<finally\>:'	. '\<end\s\+try\>'
let s:matchpairs_other	= '\%(\<end\s\+\)\@\<\!\<\(class\|enum\|while\|for\|foreach\|ifdef\|block\)\>:' . '\<end\s\+\1\>'
let b:match_words = &matchpairs . ',' . s:matchpairs_func . ',' . s:matchpairs_if . ',' . s:matchpairs_switch . ',' . s:matchpairs_try . ',' . s:matchpairs_other

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
