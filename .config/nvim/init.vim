"  __     ___
"  \ \   / (_)_ __ ___
"   \ \ / /| | '_ ` _ \   Ftw
"    \ V / | | | | | | |
"     \_/  |_|_| |_| |_|  alexebird@gmail.com
"

" auto-install plug.vim
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

"Plug 'gmarik/Vundle.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/taglist.vim'
Plug 'airblade/vim-gitgutter'
"Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
"Plug 'tpope/vim-sleuth'
"Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'slim-template/vim-slim'
"Plug 'kchmck/vim-coffee-script'
Plug 'thoughtbot/vim-rspec'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'majutsushi/tagbar'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
"Plug 'Valloric/YouCompleteMe'
"Plug 'simnalamburt/vim-mundo'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'
"Plug 'rking/ag.vim'
Plug 'mileszs/ack.vim'
Plug 'lmeijvogel/vim-yaml-helper'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Lokaltog/vim-easymotion'
"Plug 'regedarek/ZoomWin'
Plug 'ekalinin/Dockerfile.vim'
"Plug 'rodjek/vim-puppet'
"Plug 'asymmetric/upstart.vim'
Plug 'jamessan/vim-gnupg'
Plug 'alexebird/vim-ansible-yaml'
"Plug 'robertmeta/nofrils'
"Plug 'mustache/vim-mustache-handlebars'
Plug 'robertmeta/nofrils'
Plug 'mustache/vim-mustache-handlebars'
" motion mods
"Plug 'bkad/CamelCaseMotion'
" clj
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-sexp'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slime-lang/vim-slime-syntax'
" rust
"Plug 'rust-lang/rust.vim'
" hashicorp
Plug 'hashivim/vim-terraform'
"Plug 'dleonard0/pony-vim-syntax'
Plug 'rhysd/vim-crystal'
" golang
Plug 'fatih/vim-go'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"
" begin vim configuration
"

" required for vim-textobj-rubyblock
runtime macros/matchit.vim

set shell=/bin/bash
"set t_Co=256
set backspace=indent,eol,start
"set encoding=utf-8

syntax on
syntax enable

"let g:solarized_termcolors=256
"let g:solarized_visibility = 'high'
"let g:solarized_contrast = 'high'
set background=dark
"colorscheme solarized
"colorscheme cyberpunk
"colorscheme nofrils-dark
colorscheme desert

set tabstop=4
set shiftwidth=4
set expandtab
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set showcmd
set nowrap
set linebreak
set hidden
set undofile
set undodir=~/tmp/vim/undo
set laststatus=2
set notitle
set synmaxcol=300 " Avoids editor lockup in files with extremely long lines."
set listchars=eol:$
"set autowriteall  " <---- huh??
"set colorcolumn=80
" Elimiate delay switching to normal mode
set timeoutlen=500 ttimeoutlen=0
let mapleader = ","
nnoremap <Space> <Nop>
let maplocalleader=" "
nmap <F10> :set paste!<CR>
noremap <leader>n :set relativenumber!<cr>

" don't enter ex mode with Q
nnoremap Q <nop>
" Clear highlighted search results.
nnoremap <silent> <c-l> :noh<cr>

" backup to ~/.tmp
set backup
set backupdir=~/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/tmp,/tmp
set writebackup


command! SS source $MYVIMRC
command! SV edit ~/.config/nvim/init.vim
command! TT ! ctags -R --languages=ruby --exclude=.git --exclude=log .
"command! TT silent ! ctags -R --languages=ruby --exclude=.git --exclude=log . | execute ':redraw!'
command! E Eval
command! EE %Eval

" this makes everything you do fuck with the system clipboard
"set clipboard=unnamedplus

nmap <leader>a <leader>h
nmap <leader>s <leader>j
nmap <leader>d <leader>k
nmap <leader>f <leader>l

noremap <leader>r :NERDTreeToggle<cr>
noremap <leader>e :TagbarToggle<cr>
"let g:tagbar_left = 1

"noremap <leader>w :wa<cr>
noremap <leader>. :wa<cr>
noremap <leader>z :st<cr>
"noremap <leader>tn :tabnew<cr>
"noremap <leader>tc :tabclose<cr>

map <leader>x <Plug>NERDCommenterToggle

inoremap <C-d> <Del>
inoremap <C-t> <Esc>xpa

inoremap <C-b> <Left>
vnoremap <C-b> <Left>

inoremap <C-f> <Right>
vnoremap <C-f> <Right>

inoremap <C-a> <Esc>^i
"vnoremap <C-a> ^

inoremap <C-e> <Esc>$a
"vnoremap <C-e> $

" Don't move around in insert mode
"inoremap <up>    <nop>
"inoremap <down>  <nop>
"inoremap <left>  <nop>
"inoremap <right> <nop>

autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby let g:rubycomplete_classes_in_global=1

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile user-data set filetype=yaml
au BufRead,BufNewFile *.conf set filetype=upstart
au FileType sh setl sw=4 sts=5 et
au FileType bash setl sw=4 sts=5 et

" Navigate through wrapped lines intuitively
imap <silent> <down> <c-o>gj
imap <silent> <up> <c-o>gk
nmap <silent> <down> gj
nmap <silent> <up> gk
nmap <silent> j gj
nmap <silent> k gk

" Rspec mappings
"map <leader>t :call RunCurrentSpecFile()<CR>
"map <leader>s :call RunNearestSpec()<CR>
"map <leader>l :call RunLastSpec()<CR>
"map <leader>a :call RunAllSpecs()<CR>

autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal nonumber | endif

" Searching
" global search prompt
nnoremap \ :Ack! ''<Left>
" global search for whole word under cursor using '|' character
nnoremap <bar> :Ack! '\b<cword>\b'<CR>
" global search for word under cursor as text
nnoremap g\ :Ack! <cword><CR>
" global search for selection (<Esc> clears the range)
vnoremap \ "9y<Esc>:Ack! '<C-r>9'<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep --hidden --smart-case --skip-vcs-ignores'
endif

" search for selection
" Esc to clear the selection, then search for the last selected thing.
vnoremap * "9y<Esc>/<C-r>9<CR>
vnoremap # "9y<Esc>?<C-r>9<CR>

" mouse select and scroll
set mouse=a


"
" Clipboard Shit
"

" yank selection to system clipboard
vnoremap Y "+y
"vnoremap Y "zy | :call CopyRegToClipboard()<CR>
"vnoremap Y :call CopyRegToClipboard()<CR>
"vnoremap <silent> Y :'<,'>w !pbcopy<CR><CR>

" yank line to system clipboard without trailing newline
nnoremap Y ^"+y$
"nnoremap Y ^"zy$ | exec system("pbcopy", @z)

" yank line to system clipboard
nnoremap YY "+yy
"nnoremap <silent> YY :.w !pbcopy<CR><CR>

" paste from system clipboard
"nnoremap + o<ESC>"+p==
nnoremap + "+p
"nnoremap + :r !pbpaste<CR>

function! CopyFilnameToClipboard()
    let @+=@%
    "exec system("pbcopy", @%)
    execute 'file'
endfunction

"function! CopyRegToClipboard()
    "exec system("pbcopy", @z)
"endfunction

nnoremap <silent> <C-c> :call CopyFilnameToClipboard()<CR>

" / clipboard


cnoremap <C-w>q <C-w>c
cnoremap <C-w><C-q> <C-w>c
autocmd CmdwinEnter * :set nonumber
autocmd CmdwinLeave * :set number

nnoremap <C-w>, <C-w>10<
nnoremap <C-w>. <C-w>10>


" Shell command to generate ctags for ruby
"ctags -R --languages=ruby --exclude=.git --exclude=log .



"----------------------------------------------------------------------
" Plugins
"----------------------------------------------------------------------

" NERDTree
let g:nerdtree_tabs_open_on_gui_startup=0
"let NERDTreeSortOrder=[]
let g:NERDTreeIgnore = ['^__pycache__$']

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
" default section_z from https://github.com/bling/vim-airline/blob/master/autoload/airline/init.vim#L107
let g:airline_section_z = airline#section#create(['%p%%', 'linenr', ':%c'])
let g:airline_left_sep=''
let g:airline_right_sep=''


" ctrlp
let g:ctrlp_map = '<C-p>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_root_markers = ['Gemfile', 'project.clj']
"let g:ctrlp_match_window_reversed = 0
"let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden --smart-case --skip-vcs-ignores -g ""'
" overcome limit imposed by max height
let g:ctrlp_match_window = 'results:50'
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_mruf_exclude = '/tmp/.*\|\.git/.*'
nnoremap <C-h> :CtrlPTag<CR>
nnoremap <C-j> :CtrlPMRU<CR>
nnoremap <C-k> :CtrlPBuffer<CR>


" tagbar
"let g:tagbar_sort = '0'


"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" mundo (undo-tree)
"nnoremap <leader>g :MundoToggle<cr>
"let g:mundo_prefer_python3 = 0


" gitgutter
"highlight clear SignColumn
"highlight SignColumn ctermbg=bg
highlight GitGutterAdd ctermfg=darkgreen
highlight GitGutterChange ctermfg=darkyellow
highlight GitGutterDelete ctermfg=darkred
highlight GitGutterChangeDelete ctermfg=darkyellow
command! GR GitGutterUndoHunk


" auto-pairs
let g:AutoPairsShortcutFastWrap = '<C-s>'
let g:surround_no_insert_mappings = 1


" syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': ['python'] }
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_sh_checkers = ['shellcheck']


" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap S <Plug>(easymotion-s2)
" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion"
" JK motions: Line motions
"map <Leader>l <Plug>(easymotion-lineforward)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
"map <Leader>h <Plug>(easymotion-linebackward)

let g:GPGExecutable = 'gpg2'


" supertab
"let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCrMapping = 1
let g:SuperTabDefaultCompletionType = "<c-n>"


" rainbow parens
let g:rbpt_colorpairs = [
	\ ['darkgrey',    'RoyalBlue3'],
	\ ['darkmagenta', 'SeaGreen3'],
	\ ['darkgreen',   'DarkOrchid3'],
	\ ['white',       'firebrick3'],
	\ ['darkyellow',  'RoyalBlue3'],
	\ ['darkblue',    'SeaGreen3'],
	\ ['red',         'DarkOrchid3'],
	\ ['cyan',        'firebrick3'],
	\ ['darkyellow',  'RoyalBlue3'],
	\ ['magenta',     'SeaGreen3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkred',     'DarkOrchid3'],
	\ ['darkblue',    'firebrick3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['darkyellow',  'firebrick3'],
	\ ]

"let s:pairs = [
	"\ ['brown',       'RoyalBlue3'],
	"\ ['Darkblue',    'SeaGreen3'],
	"\ ['darkgray',    'DarkOrchid3'],
	"\ ['darkgreen',   'firebrick3'],
	"\ ['darkcyan',    'RoyalBlue3'],
	"\ ['darkred',     'SeaGreen3'],
	"\ ['darkmagenta', 'DarkOrchid3'],
	"\ ['brown',       'firebrick3'],
	"\ ['gray',        'RoyalBlue3'],
	"\ ['black',       'SeaGreen3'],
	"\ ['darkmagenta', 'DarkOrchid3'],
	"\ ['Darkblue',    'firebrick3'],
	"\ ['darkgreen',   'RoyalBlue3'],
	"\ ['darkcyan',    'SeaGreen3'],
	"\ ['darkred',     'DarkOrchid3'],
	"\ ['red',         'firebrick3'],
	"\ ]
"au FileType clojure RainbowParenthesesActivate
"au Syntax clojure RainbowParenthesesLoadRound
"au Syntax clojure RainbowParenthesesLoadSquare
"au Syntax clojure RainbowParenthesesLoadBraces

"au FileType elixir colorscheme slate

"autocmd FileType clojure nnoremap <buffer> cpc :Eval<cr>

autocmd Filetype terraform setlocal et ts=2 sw=2 sts=2
autocmd Filetype ruby setlocal et ts=2 sw=2 sts=2
autocmd Filetype bash setlocal et ts=2 sw=2 sts=2 iskeyword+=:
autocmd Filetype sh setlocal et ts=2 sw=2 sts=2 iskeyword+=:
autocmd Filetype json setlocal et ts=2 sw=2 sts=2
autocmd Filetype javascript setlocal et ts=2 sw=2 sts=2
autocmd Filetype yaml setlocal et ts=2 sw=2 sts=2
autocmd Filetype crystal setlocal et ts=2 sw=2 sts=2
autocmd Filetype html setlocal et ts=2 sw=2 sts=2
autocmd Filetype css setlocal et ts=2 sw=2 sts=2
autocmd Filetype qf setlocal cursorline
autocmd BufRead,BufNewFile *.hcl setlocal ft=terraform et ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.hcl.tmpl setlocal ft=terraform et ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.hcl.mustache setlocal ft=terraform.mustache et ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.yml.ctmpl  setlocal ft=yaml.mustache et ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.conf.ctmpl setlocal ft=conf.mustache et ts=2 sw=2 sts=2

hi Search cterm=NONE ctermfg=black ctermbg=green


function! PutsDate()
    put =strftime('# %c')
endfunction

command! Date call PutsDate()


"function! ResizeForWideAssMonitor()
    "vertical resize 100
"endfunction

"command! RR call ResizeForWideAssMonitor()

" golang
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" colors for error popup
hi default CocFloating ctermfg=Red ctermbg=White
