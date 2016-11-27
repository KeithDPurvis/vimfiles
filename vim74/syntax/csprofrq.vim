
" Vim syntax file
" Language:     CSPro freq files
" Current  Maintainer:  Keith Purvis <kpurvis@icfi.com>
" Last Change:  2010 November 16

" Remove any old syntax stuff hanging around
syn clear

syn keyword frqstatement Categories Frequency CumFreq Cum Net cNet Page Occurrences tbd-name TOTAL Statistics
syn keyword frqLabel Missing NotAppl Default
syn case ignore

" String

"if you prefer you can highlight the range
"syn match  frqMatrixDelimiter "[\d\+\.\.\d\+]"

syn match  frqNumber           "-\=\<\d\+\.\d\+[dD]-\=\d\+\>"
syn match  frqNumber           "-\=\<\d\+\.\d\+[eE]-\=\d\+\>"
syn match  frqNumber           "-\=\<\d\+\.\d\+\>"
syn match  frqNumber           "-\=\<\d\+\>"
syn match  frqByte             "\$[0-9a-fA-F]\+\>"

" If you don't like tabs
"syn match frqShowTab "\t"
"syn match frqShowTabc "\t"

syntax region  frqstring	start="^Item" end="$" 
syn region frqcomment  start="tbd-name: '"  end="'" contains=csproTodo

syn sync lines=250

if !exists("did_frq_syntax_inits")
  let did_frq_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link frqComment                   Comment
  hi link frqConstant                  Constant
  hi link frqConditional               Conditional
  hi link frqFunction          Statement
  hi link frqLabel                     Label
  hi link frqNumber                    Number
  hi link frqOperator          Operator
  hi link frqRepeat                    Repeat
  hi link frqStatement         Statement
  hi link frqString                    String
  hi link frqTitle                    String
  hi link frqStructure         Tag 
  hi link frqProc         Underlined
  hi link frqTodo                      Todo
  hi link frqUnclassified              Statement

"optional highlighting
  hi link frqDelimiter         Identifier
  hi link frqShowTab                   Error
  hi link frqShowTabc          Error
  hi link frqIdentifier                Identifier
endif

let b:current_syntax = "csprofrq"

 set ts=8
 set sw=2
