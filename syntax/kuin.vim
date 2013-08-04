" Vim syntax file
" Language:     Kuin
" Maintainer:   @tatt61880
" Last Modified:2013/08/04 09:27:05.
"
" == Usage ==
" Put this file into "syntax" folder.

if exists("b:current_syntax")
    finish
endif

"set foldmethod=syntax

" suffixesadd is for "gf" command.
set suffixesadd=.kn

syntax case match

syn match   kuinDoLessError /\v%(^\s*)@<=\w.*/ " for forgetting 'do'
syn match   kuinSpecial /#/
syn match   kuinSpecial /@/

" *Comment {{{1
syn region  kuinBlockCommen_t
            \ start='{'
            \ end='}'
            \ fold
            \ contains=kuinBlockCommen_t,kuinString,kuinCharacter,kuinTodo
" }}}1
" *Constant {{{1
syn keyword kuinConstant null inf
syn region  kuinString
            \ start=/"/
            \ end=/"\|$/
            \ skip=/\v%(\\)@<!%(\\\\)*\\"/
            \ contains=kuinCharacterError
syn match   kuinCharacter /'[^\']'/
syn match   kuinCharacter /'\\.'/ contains=kuinCharacterError
syn match   kuinCharacterError /\v%(%(\\)@<!\\%(\\\\)*)@<!\\0/ contained " \0 isn't arrowed

" kuinNumber {{{2
syn match   kuinError  /\v<\d\w+>/      " e.g. 1000_000 => Error, 100yen => Error
syn match   kuinNumber /\v<0%(\.\d+)=>/
syn match   kuinNumber /\v<[1-9]\d*%(\.\d+)=>/
syn match   kuinError  /\v<10#/         " e.g.  10#9999 => Error
syn match   kuinError  /\v<\d+#\w+>/    " e.g. 100#FFFF => Error, 8#8888 => Error
syn match   kuinNumber /\v<2#[0-1]+%(\.[0-1]+)=>/
syn match   kuinNumber /\v<3#[0-2]+%(\.[0-2]+)=>/
syn match   kuinNumber /\v<4#[0-3]+%(\.[0-3]+)=>/
syn match   kuinNumber /\v<5#[0-4]+%(\.[0-4]+)=>/
syn match   kuinNumber /\v<6#[0-5]+%(\.[0-5]+)=>/
syn match   kuinNumber /\v<7#[0-6]+%(\.[0-6]+)=>/
syn match   kuinNumber /\v<8#[0-7]+%(\.[0-7]+)=>/
syn match   kuinNumber /\v<9#[0-8]+%(\.[0-8]+)=>/
syn match   kuinNumber /\v<11#[0-9a]+%(\.[0-9a]+)=>/
syn match   kuinNumber /\v<12#[0-9ab]+%(\.[0-9ab]+)=>/
syn match   kuinNumber /\v<13#[0-9a-c]+%(\.[0-9a-c]+)=>/
syn match   kuinNumber /\v<14#[0-9a-d]+%(\.[0-9a-d]+)=>/
syn match   kuinNumber /\v<15#[0-9a-e]+%(\.[0-9a-e]+)=>/
syn match   kuinNumber /\v<16#[0-9a-f]+%(\.[1-9a-f]+)=>/
syn match   kuinNumber /\v<17#[0-9a-g]+%(\.[0-9a-g]+)=>/
syn match   kuinNumber /\v<18#[0-9a-h]+%(\.[0-9a-h]+)=>/
syn match   kuinNumber /\v<19#[0-9a-i]+%(\.[0-9a-i]+)=>/
syn match   kuinNumber /\v<20#[0-9a-j]+%(\.[0-9a-j]+)=>/
syn match   kuinNumber /\v<21#[0-9a-k]+%(\.[0-9a-k]+)=>/
syn match   kuinNumber /\v<22#[0-9a-l]+%(\.[0-9a-l]+)=>/
syn match   kuinNumber /\v<23#[0-9a-m]+%(\.[0-9a-m]+)=>/
syn match   kuinNumber /\v<24#[0-9a-n]+%(\.[0-9a-n]+)=>/
syn match   kuinNumber /\v<25#[0-9a-o]+%(\.[0-9a-o]+)=>/
syn match   kuinNumber /\v<26#[0-9a-p]+%(\.[0-9a-p]+)=>/
syn match   kuinNumber /\v<27#[0-9a-q]+%(\.[0-9a-q]+)=>/
syn match   kuinNumber /\v<28#[0-9a-r]+%(\.[0-9a-r]+)=>/
syn match   kuinNumber /\v<29#[0-9a-s]+%(\.[0-9a-s]+)=>/
syn match   kuinNumber /\v<30#[0-9a-t]+%(\.[0-9a-t]+)=>/
syn match   kuinNumber /\v<31#[0-9a-u]+%(\.[0-9a-u]+)=>/
syn match   kuinNumber /\v<32#[0-9a-v]+%(\.[0-9a-v]+)=>/
syn match   kuinNumber /\v<33#[0-9a-w]+%(\.[0-9a-w]+)=>/
syn match   kuinNumber /\v<34#[0-9a-x]+%(\.[0-9a-x]+)=>/
syn match   kuinNumber /\v<35#[0-9a-y]+%(\.[0-9a-y]+)=>/
syn match   kuinNumber /\v<36#[0-9a-z]+%(\.[0-9a-z]+)=>/
" }}}2 
syn keyword kuinBoolean true false
syn match   kuinFloat  /\v<[1-9]\d*%(\.\d+)=e[+-]=[1-9]\d*>/  " 314159e-5
syn match   kuinFloat  /\v<0.\d+e[+-]=[1-9]\d*>/ " 0.1e+6
" }}}1
" *Identifier {{{1
syn match   kuinIdentifier /\<\h\w*\>/ transparent
syn keyword kuinKeyword this
syn keyword kuinFunction Init Main Free Err
syn keyword kuinNamespace Kuin Dbg File Rnd Lib SaveData Draw Snd Input BGM
syn match   kuinFunction "\v<%(Kuin\@)@<=Stop>"
syn match   kuinFunction "\v<%(Kuin\@)@<=Act>"
"syn keyword kuinFunction ToStr Len Copy
"syn keyword kuinFunction Ctor Dtor
" }}}1
" *Statement {{{1
syn keyword kuinStatement skip err var break return continue assert
syn keyword kuinDoStatement do
syn region  kuinBlock
            \ matchgroup=kuinStatement
            \ start=/\v%(^\s*\-?\s*\+?\s*)@<=<func>/
            \ end=/\v%(^\s*)@<=<end\s+func>/
            \ fold
            \ contains=ALLBUT,kuinClassError
syn region  kuinBlock
            \ matchgroup=kuinStatement
            \ start=/\v%(^\s*)@<=<block>/
            \ end=/\v%(^\s*)@<=<end\s+block>/
            \ fold
            \ contains=ALLBUT,kuinClassError
syn match   kuinStatement "@new\>"
syn keyword kuinConditional else elif
syn region  kuinBlock
            \ matchgroup=kuinConditional
            \ start=/\v%(^\s*)@<=<\z(if|switch)>/
            \ end=/\v%(^\s*)@<=<end\s+\z1>/
            \ fold
            \ contains=ALLBUT,kuinClassError
syn region  kuinBlock
            \ matchgroup=kuinRepeat
            \ start=/\v%(^\s*)@<=<\z(while|for|foreach)>/
            \ end=/\v%(^\s*)@<=<end\s+\z1>/
            \ fold
            \ contains=ALLBUT,kuinClassError
syn keyword kuinLabel case default
syn match   kuinError      "\v%(var\s+\w+\s*\:\s*%(\[\])*\w+)@<=\s*\:\:.*" " ::
syn match   kuinOperator   "\v\s*\:%(\:|\+|\-|\*|\/|\%|\^|\~|\$)" contained " ::
syn match   kuinOperator   "\~" contained
syn match   kuinOperator   "=&" contained
syn match   kuinOperator   "+" contained
syn match   kuinOperator   "-" contained
syn match   kuinOperator   "*" contained
syn match   kuinOperator   "/" contained
syn match   kuinOperator   "%" contained
syn match   kuinOperator   "^" contained
syn match   kuinOperator   "!" contained
syn match   kuinClassError "\v%(var\s+\w+\s*\:\s*%(\[\])*\w+)@<=\s*\:\:.*" contained
syn match   kuinOperator "?("
syn match   kuinOperator "#"
syn match   kuinOperator /\v\=/
syn match   kuinError    /\v\={2,}/     " Use =    instead of ==
syn match   kuinError    /;/
syn match   kuinError    /\v%(<do\s+\w+%(\[\d+\])*\s*)@<=\=/  " [do VName =] isn't correct sentence.
syn match   kuinError    /\v%(<var\s+\w+\s*\:\s*%(\[\])*\w+\s*)@<=\=/  " [var VName : Type =] isn't correct sentence.
syn match   kuinOperator /\v\<\>/
syn match   kuinError    /\v!\=/        " Use <>   instead of !=
syn match   kuinOperator /\v\&/
syn match   kuinError    /\v\&{2,}/     " Use &    instead of &&
syn match   kuinOperator /\v\|/
syn match   kuinError    /\v\|{2,}/     " Use |    instead of ||
syn match   kuinError    /\v\+{2,}/     " Use :+ 1 instead of ++
syn match   kuinError    /\v\-{2,}/     " Use :- 1 instead of --
syn match   kuinOperator /\v(\<|\>)\=?/ " <, >, <=, >=
syn match   kuinOperator /\v\$/         " $ (cast operator)
syn keyword kuinException throw catch finally
syn region  kuinBlock
            \ matchgroup=kuinException
            \ start=/\v%(^\s*)@<=<try>/
            \ end=/\v%(^\s*)@<=<end\s+try>/
            \ fold
            \ contains=ALLBUT,kuinClassError
" }}}1
" *PreProc {{{1
syn keyword kuinPreCondit dbg rls
syn region  kuinBlock
            \ matchgroup=kuinPreCondit
            \ start=/\v%(^\s*)@<=<ifdef>/
            \ end=/\v%(^\s*)@<=<end\s+ifdef>/
            \ fold
            \ contains=ALLBUT,kuinClassError
" }}}1
" *Type {{{1
syn keyword kuinType int float char bool complex money ratio list stack queue dict
syn match   kuinType "\v%(^\s*[+-]?\s*\*?\s*)@<!<func>"
syn keyword kuinType byte8 byte16 byte32 byte64
syn keyword kuinStorageClass const
syn region  kuinBlock
            \ matchgroup=kuinStructure
            \ start=/\v%(^\s*-?\s*)@<=<enum>/
            \ end=/\v%(^\s*)@<=<end\s+enum>/
            \ fold
            \ contains=ALLBUT,kuinDoLessError
syn region  kuinBlock
            \ matchgroup=kuinStructure
            \ start=/\v%(^\s*-?\s*)@<=<class>/
            \ end=/\v%(^\s*)@<=<end\s+class>/
            \ fold
            \ contains=ALLBUT,kuinDoStatement
syn keyword kuinTypedef alias
" }}}1
" *Todo {{{1
syn keyword kuinTodo contained TODO FIXME XXX
syn match   kuinTodo contained "\v\s@<=☆\s@="
" }}}1

" def link {{{1
" *Comment
hi def link kuinBlockCommen_t   Comment
" *Constant
hi def link kuinConstant        Constant
hi def link kuinString          String
hi def link kuinCharacter       Character
hi def link kuinNumber          Number
hi def link kuinBoolean         Boolean
hi def link kuinFloat           Float
" *Identifier
hi def link kuinIdentifier      Identifier
hi def link kuinFunction        Function
" *Statement
hi def link kuinStatement       Statement
hi def link kuinDoStatement     Statement
hi def link kuinConditional     Conditional
hi def link kuinRepeat          Repeat
hi def link kuinLabel           Label
hi def link kuinOperator        Operator
hi def link kuinKeyword         Keyword
hi def link kuinException       Exception
" *PreProc
hi def link kuinPreCondit       PreCondit
" *Type
hi def link kuinType            Type
hi def link kuinStorageClass    StorageClass
hi def link kuinStructure       Structure
hi def link kuinTypedef         Typedef
" *Special
hi def link kuinSpecial         Special
" *Error
hi def link kuinError           Error
hi def link kuinCharacterError  Error
hi def link kuinClassError      Error
hi def link kuinDoLessError     Error
" *Todo
hi def link kuinTodo            Todo
" }}}1

let b:current_syntax = "kuin"
syn sync fromstart

" Setting for matchit.vim
" http://www.vim.org/scripts/script.php?script_id=39
let s:matchpairs_func   = '\%(\%(\w\|\:\)\s\+\)\@\<\!\<func\>:' . '\<end\s\+func\>'
let s:matchpairs_if     = '\%(\<end\s\+\)\@\<\!\<if\>:'     . '\<elif\>:'  . '\<else\>:'    . '\<end\s\+if\>'
let s:matchpairs_switch = '\%(\<end\s\+\)\@\<\!\<switch\>:' . '\<case\>:'  . '\<default\>:' . '\<end\s\+switch\>'
let s:matchpairs_try    = '\%(\<end\s\+\)\@\<\!\<try\>:'    . '\<catch\>:' . '\<finally\>:' . '\<end\s\+try\>'
let s:matchpairs_other  = '\%(\<end\s\+\)\@\<\!\<\(class\|enum\|while\|for\|foreach\|ifdef\|block\)\>:' . '\<end\s\+\1\>'
let b:match_words = &matchpairs . ',' . s:matchpairs_func . ',' . s:matchpairs_if . ',' . s:matchpairs_switch . ',' . s:matchpairs_try . ',' . s:matchpairs_other

" vim:ts=4:sts=4:sw=4:expandtab:ft=vim
