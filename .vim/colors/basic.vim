" Vim color file
" Maintainer:	Mikel Ward <mikel@mikelward.com>
" Last Change:	2008 Jan 16

" Remove all existing highlighting and set the defaults.
highlight clear

" Load the syntax highlighting defaults, if it's enabled.
"if exists("syntax_on")
"	syntax reset
"endif

let colors_name = "basic"

" Remove all highlighting
highlight clear Constant
highlight clear Number
highlight clear Statement
highlight clear PreProc
highlight clear Type
highlight clear Special
highlight clear Identifier

highlight clear String
highlight clear Comment
highlight clear Error
highlight clear LineNr
highlight clear NonText
highlight clear SpecialKey

" Set up some simple non-intrusive colors
if &background == "dark"
	highlight Normal term=NONE cterm=NONE ctermfg=White
	highlight String term=underline cterm=NONE ctermfg=Gray
	highlight Comment term=bold cterm=NONE ctermfg=LightGray
	highlight Error term=reverse cterm=NONE ctermbg=Red
	highlight LineNr term=bold cterm=NONE ctermfg=DarkGray
	highlight NonText term=bold cterm=NONE ctermfg=DarkGray
	highlight SpecialKey term=bold cterm=NONE ctermfg=Yellow
endif

