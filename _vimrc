" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2000 Mar 29
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set nobackup		" do not keep a backup file, use versions instead
set noswapfile		" do not keep a swap file
set undofile
set undodir=c:\vim\undodir
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=200		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set hidden		" allow multiple buffers
set nowrap		" no need to wrap text for programs
set ic		        " makes pattern searches case insensitive
set sidescroll=1
set nowrap
set showmode
set showcmd
set ttyfast
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set novisualbell
set sc
set autoread            "Always load new version of file if changed by external program
set printfont=Consolas:h8
set path=..\dicts,..\recode,..\entry,..\editing,..\tables,..\others
set runtimepath^=c:\vim\bundle\ctrlp.vim
" remove menu + toolbar
set guioptions-=m
set guioptions-=T
"if has('gui_running')
"    set background=light
"else
"    set background=dark
"endif
set background=dark
set cursorline
" get vim to search upwards for tags files
set tags=tags;
set wildmenu
"prevent vertical windows resizing the others if closed
set eadirection=ver
"show whitespace and tabs
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set diffopt=vertical
" set home directory 
let $HOME = $USERPROFILE 
" snipmate
" pathogen 
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" set filetype, plugin stuff
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
let Tlist_Ctags_Cmd='C:\vim\vim74\ctags58\ctags.exe'
set omnifunc=syntaxcomplete#Complete
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "M", "", "")
" Don't use Ex mode, use Q for formatting
map Q gq
" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.

if has("gui_running")
  syntax on
  set hlsearch
  colors obsidian2
else
 colors candycode
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
 " In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78
 autocmd BufRead *.txt set wrap
 autocmd BufRead *.txt set wrapmargin=78
 "use ms linedraw for cspro output txt files to display line characters properly
 autocmd BufRead *.tbl set guifont=MS_Linedraw:h8
 " otherwise use consolas font 
 autocmd BufRead *.frq,*.frw set guifont=Consolas:h10
 autocmd BufRead *.dcf,*.app,*.att,*.msg,*.lst set guifont=Consolas:h10
 autocmd BufRead *.dcf,*.app,*.mgf setlocal spell spelllang=en_us,es,fr
 autocmd BufRead *.app set sw=2
 autocmd BufRead *.app set et
"autocmd BufRead *.app setlocal foldmethod=indent
 " set spelchecker on 
 "show cursor column when reading .dat files 
 autocmd BufRead *.dat setlocal cursorcolumn 
 autocmd BufRead *.frq match ErrorMsg /^@/
 autocmd BufRead *.frq 2match ErrorMsg /^\s\+Default/
 autocmd GUIEnter * simalt ~x
 " change local directory to current dir of file for some Cspro files
 autocmd BufEnter *.app,*.frq,*.lst,*.tbl lcd %:p:h
 autocmd FileType python set omnifunc=pythoncomplete#Complete
 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType app  set formatoptions=croql cindent cinw=if else elseif for do while box recode proc level declare preproc postproc comments=sr:{,,el:}
  autocmd FileType vb  set  formatoptions=croql cindent cinw=if while loop for foreach next function sub comments=sr:{,,el:}
  " save CSPro application files when lose focus
 autocmd FocusLost *.app,*.apc,*.pff,*.dcf,*.bch,*.ent,*.mgf :w!
:syntax on

  "autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

function! FoldSpellBalloon()
	let foldStart = foldclosed(v:beval_lnum )
	let foldEnd = foldclosedend(v:beval_lnum)
	let lines = []
	" Detect if we are in a fold
	if foldStart < 0
		" Detect if we are on a misspelled word
		let lines = spellsuggest( spellbadword(v:beval_text)[ 0 ], 5, 0 )
	else
		" we are in a fold
		let numLines = foldEnd - foldStart + 1
		" if we have too many lines in fold, show only the first 14
		" and the last 14 lines
		if ( numLines > 31 )
			let lines = getline( foldStart, foldStart + 14 )
			let lines += [ '-- Snipped ' . ( numLines - 30 ) . ' lines --' ]
			let lines += getline( foldEnd - 14, foldEnd )
		else
			"less than 30 lines, lets show all of them
			let lines = getline( foldStart, foldEnd )
		endif
	endif
	" return result
	return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
endfunction



 augroup dic
  " Remove all dic autocommands
  au!

  " Enable editing of ISSA dictionaries
  " set binary mode before reading the file
  autocmd BufReadPre,FileReadPre	*.dic,*.wst set bin
  autocmd BufReadPost,FileReadPost	*.dic,*.wst call Dic_read("c:\\issautil\\writetxt")
  autocmd BufWritePost,FileWritePost	*.dic,*.wst call Dic_write("c:\\issautil\\writedic")
  autocmd FileAppendPre			*.dic,*.wst call Dic_appre("c:\\issautil\\writetxt")
  autocmd FileAppendPost		*.dic,*.wst call Dic_write("c:\\issautil\\writedic")


  " After reading compressed file: Uncompress text in buffer with "cmd"
  fun! Dic_read(cmd)
    " set 'cmdheight' to two, to avoid the hit-return prompt
    let ch_save = &ch
    set ch=3
    " when filtering the whole buffer, it will become empty
    let empty = line("'[") == 1 && line("']") == line("$")
    let rfile=expand("<afile>:r")
    let efile=expand("<afile>:e")
    " uncompress the file "!c:\\issautil\\writetxt rfile"
    execute "!" . a:cmd . " " . rfile . "." . efile . " noloc"
    " delete the compressed lines
    '[,']d
    " read in the uncompressed lines "'[-1r tmpd"
    set nobin
    execute "'[-1r " . rfile. "."."DDF"
    " if buffer became empty, delete trailing blank line
    if empty
      normal Gdd''
    endif
    let &ch = ch_save
    " When uncompressed the whole buffer, do autocommands
    if empty
      execute ":doautocmd BufReadPost " . expand("%:r")
    endif
  endfun

  " After writing compressed file: Compress written file with "cmd"
  fun! Dic_write(cmd)
    if rename(expand("<afile>"), expand("<afile>:r")) == 0
      execute "w! " . expand("<afile>:r") . ".DDF"
      execute "!" . a:cmd . " <afile>:r". "." . "DDF"
    endif
  endfun

  " Before appending to compressed file: Uncompress file with "cmd"
  fun! Dic_appre(cmd)
    execute "!" . a:cmd . " <afile>"
    call rename(expand("<afile>:r"), expand("<afile>"))
  endfun

 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 0
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif
 " Custom mappings and other modifications by Keith
 " maps for tags
  map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
  map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
 "Map Function keys
 "F5 Reload buffer
 "F8 /Shift F8- next/previous buffer
 "F9 delete buffer (without prompting if not saved 
 map <F2> :bro source<CR>
 map <F3> :bro mks<CR>
 map <F5> :e!<CR>
 map <F6> :ls<CR>:e #
 map <F7> :set nu!<CR>
 map <C-F7> :set relativenumber!<CR>
 map <F8> :bn <CR>
 map <S-F8> :bp<CR>
 map <F11> :source c:\vim\vim74\macros\bch.vim<CR>
 map <F12> :source c:\vim\vim74\macros\ent.vim<CR>
 map!<S-F8> :bp<CR>
 map! <F8> :bn <CR>
 map! <F9> :bw<CR>
 map! <S-F9> :bd<CR>
 map <F10> :TaskList<CR>
 map <C-j> <C-W>j
 map <C-k> <C-W>k
 map <C-l> <C-W>l
 map <C-h> <C-W>h
 map <C-J> <C-W>j
 map <C-K> <C-W>k
 map <C-L> <C-W>l
 map <C-H> <C-W>h
 map <C-BS> :pop<CR>
 map <C-T> *N<C-W>h n
 map <C-S> * :windo n<CR>
 map K k
 map \c i{<Esc>$a}<Esc>
 map \s i{<Esc>)a}<Esc> 
 map <C-N> : set noscb <CR>
 map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
	    \set guioptions-=T <Bar>
	    \set guioptions-=m <bar>
    \else <Bar>
	    \set guioptions+=????????T <Bar>
	    \set guioptions+=m <Bar>
    \endif<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
" use ; to go to ex mode
nnoremap <leader><space> :noh<cr>
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>
nnoremap <leader>b : bo 12 sp %:r.bch <cr>
nnoremap <leader>e : bo 12 sp %:r.ent <cr>
nnoremap <leader>p : bo 12 sp %:r.pff <cr>
nnoremap <leader>pr : bo 12 sp %:r.prm <cr>
nnoremap <leader>m : bo 12 sp %:r.mgf <cr>
nnoremap <leader>q : bo 12 sp %:r.qsf <cr>
nnoremap <leader>L : colors mayansmoke<cr>
nnoremap <leader>D : set background=dark <cr>
nnoremap <leader>l : vs %:r.lst <cr>
nnoremap <leader>w : bw! <cr>
nnoremap <leader>V : vs c:\vim\_vimrc <cr>
nnoremap <leader>f : source c:\vim\vim74\macros\openfreqs.vim <cr>
nnoremap <leader>F : setlocal foldmethod=indent <cr> 
nnoremap <leader>fm : setlocal foldmethod=manual <cr> 
nnoremap <leader>T : silent !dotags.bat <cr>
nnoremap <leader>K : exe 'vim/'.expand('<cword>').'/ ../**/*.app / ../**/*.bch ../**/*.pff' <cr>:copen<cr>
nnoremap <leader>n : s/Label=/Label=NA - /<cr>
nnoremap <leader>S : bro source
"shortcuts for large/normal font sizes
nnoremap <leader>fp : set guifont=Consolas:h16 <cr>
nnoremap <leader>fn : set guifont=Consolas:h10 <cr>
" remaps to copy file name to Windows clipboard
" absolute path (/something/src/foo.txt)
  nnoremap <leader>cfa :let @+=expand("%:p")<CR>

  " filename (foo.txt)
  nnoremap <leader>cfn :let @+=expand("%:t")<CR>

  " directory name (/something/src)
  nnoremap <leader>cfp :let @+=expand("%:p:h")<CR>

 com -bang E 12 sp %:r.err 
 com -bang M  !start c:\program files (x86)\cspro 4.1\runpff.exe %:r.pff
 com -bang M6 !start c:\program files (x86)\cspro 6.3\runpff.exe %:r.pff
 com -bang Mb !start c:\program files (x86)\cspro 4.1\csbatch.exe %:r.pff
 com -bang Me !start c:\program files (x86)\cspro 4.1\csentry.exe %:r.ent
 com -bang B !start c:\program files (x86)\cspro 6.3\csentry.exe /pen %:r.ent

 com -bang Ft set guifont=MS_Linedraw:h18
 com -bang Fs set guifont=Consolas:h18
 com -bang T  !start c:\issaw\exprtab %:r
 com -bang Tv !start gvim %:r.tbl
 com -bang Te !start "C:\Program Files (x86)\Tables\Tables.exe" %:r.tbd
 com -bang G  !start gvim
 com -bang We !start "C:\Program Files (x86)\FreeCommander XE\FreeCommander.exe /N /L=%:h /R=%:h"
 com -bang S source c:\vim\vim74\macros\ent.vim
 com -bang Sb source c:\vim\vim74\macros\bch.vim
 com -bang Ob silent !powershell.exe /c invoke-item %:r.bch 
 com -bang Oe silent !powershell.exe /c invoke-item %:r.ent 
 com -bang O  silent !powershell.exe /c invoke-item % 
 com -bang R  silent !runtab.bat %:r
 com -bang Rr silent !runtab.bat %:r r
 com -bang Y  s/\(Q\S\+\)/YesNo(\1)/
 com -bang P  vim /^\s\+PROC/j %, :cw
 command GREP :execute 'vimgrep '.expand('<cword>').'../**/*.app' | :copen | :cc

 set ic 
"set guifont=Courier_New:h10
"set guifont=Consolas:h10
 set guifont=Consolas:h10
endif 


let g:tlTokenList = ['TODO', '!!!', 'FIXME'] 
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['readme.txt']

set laststatus=2
let g:session_autosave='no'
