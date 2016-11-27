" Vim syntax file
" Language:     cspro (CSPro)
" Current  Maintainer:  Keith Purvis <kpurvis@icfi.com>
" Last Change:  2010 October 15

" Remove any old syntax stuff hanging around
syn clear

syn case ignore
syn keyword csproProc       proc 
syn keyword csproStructure  preproc postproc onfocus killfocus level

syn keyword csproStatement abs accept advance alias alpha array average box break changekeyboard xtab
syn keyword csproStatement clear close cmcode compare concat connection count countnonspecial curocc dateadd
syn keyword csproStatement datediff datevalid delcase delete demode dircreate direxist dirlist display do
syn keyword csproStatement edit editnote endcase endgroup endlevel enter errmsg execpff execsystem exit
syn keyword csproStatement exp export file fileconcat filecopy filecreate filedelete fileempty fileexist filename
syn keyword csproStatement fileread filerename filesize filewrite find  for function getbuffer getcapturetype getdeck
syn keyword csproStatement getdeviceid getimage getlabel getlanguage getnote getocclabel getoperatorid getorientation getos getrecord
syn keyword csproStatement getsymbol getusername getvalue getvaluealpha getvaluenumeric gps has high highlighted if then
syn keyword csproStatement impute in inc insert int invalueset ispartial key killfocus length
syn keyword csproStatement loadcase locate log low maketext max min move next noccurs
syn keyword csproStatement noinput numeric onchangelanguage onchar onfocus onkey onstop open pathname pos
syn keyword csproStatement preproc proc prompt postproc publishdate putdeck putnote random randomin randomizevs
syn keyword csproStatement recode reenter relation retrieve round savepartial seed seek seekmax seekmin
syn keyword csproStatement selcase setcapturepos setcapturetype set setfile setfont setlanguage setocclabel setorientation setoutput
syn keyword csproStatement setvalue setvalueset setvaluesets show showarray skip skip case soccurs sort special
syn keyword csproStatement sqrt stop string strip sum swap sync sysdate sysparm systime
syn keyword csproStatement tolower tonumber totocc toupper trace userbar universe visualvalue while write writecase
syn keyword csproStatement endif enddo endbox endrecode end else elseif rows stubsize cellsize style

syn keyword csproTodo contained  TODO
syn keyword csproconstant notappl default totals percents specval totpct rowpct colpct row column rowzero colzero missing suppress
syn keyword csproconstant implicit explicit autoskip native display visible return protect hidden native assisted on off
syn keyword csproconstant text button field spacing 




" String
syn region  csproString  start=+"+  end=+"+
syn region  csproString  start=+#+  end=+#+

syn match  csproIdentifier               "\<[a-zA-Z_][a-zA-Z0-9_]*\>"
syn match  csproDelimiter                "[()]"

syn match  csproMatrixDelimiter  "[][]"

"if you prefer you can highlight the range
"syn match  csproMatrixDelimiter "[\d\+\.\.\d\+]"

syn match  csproNumber           "-\=\<\d\+\.\d\+[dD]-\=\d\+\>"
syn match  csproNumber           "-\=\<\d\+\.\d\+[eE]-\=\d\+\>"
syn match  csproNumber           "-\=\<\d\+\.\d\+\>"
syn match  csproNumber           "-\=\<\d\+\>"
syn match  csproByte             "\$[0-9a-fA-F]\+\>"

" If you don't like tabs
"syn match csproShowTab "\t"
"syn match csproShowTabc "\t"

syn region csproComment  start="{"  end="}" contains=csproTodo
syntax region  csproComment	start="//" skip="\\$" end="$" contains=csproTodo

syn region csproString matchgroup=csproStatement start=/Title\s*(\s*"/ start=/Stub\s*(\s*"/ end = /"\s*)/ contains=@spell

syn sync lines=250

if !exists("did_cspro_syntax_inits")
  let did_cspro_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link csproComment                   Comment
  hi link csproConstant                  Constant
  hi link csproConditional               Conditional
  hi link csproFunction          Statement
  hi link csproLabel                     Label
  hi link csproNumber                    Number
  hi link csproOperator          Operator
  hi link csproRepeat                    Repeat
  hi link csproStatement         Statement
  hi link csproString                    String
  hi link csproTitle                    String
  hi link csproStructure         Tag 
  hi link csproProc         Underlined
  hi link csproTodo                      Todo
  hi link csproUnclassified              Statement

"optional highlighting
  hi link csproDelimiter         Identifier
  hi link csproShowTab                   Error
  hi link csproShowTabc          Error
  hi link csproIdentifier                Identifier
endif

let b:current_syntax = "cspro"

 set ts=8
 set sw=2
