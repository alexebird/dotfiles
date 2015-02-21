set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
"
" original repos on github
" Plugin 'tpope/vim-fugitive'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Plugin 'tpope/vim-rails.git'
" vim-scripts repos
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" non github repos
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
" Plugin 'file:///Users/gmarik/path/to/plugin'
" ...
"
Plugin 'vim-ruby/vim-ruby'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'taglist.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'slim-template/vim-slim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'thoughtbot/vim-rspec'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'jnwhiteh/vim-golang'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ervandew/supertab'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'sjl/gundo.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/syntastic'
Plugin 'rking/ag.vim'
Plugin 'lmeijvogel/vim-yaml-helper'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'regedarek/ZoomWin'
Plugin 'ekalinin/Dockerfile.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" required for vim-textobj-rubyblock
runtime macros/matchit.vim

set shell=/bin/bash
"set t_Co=256
set backspace=indent,eol,start
set encoding=utf-8

syntax on
syntax enable

"let g:solarized_termcolors=256
"let g:solarized_visibility = 'high'
"let g:solarized_contrast = 'high'
set background=dark
colorscheme solarized

set tabstop=4
set shiftwidth=4
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set showcmd
set nowrap
set linebreak
set laststatus=2
"set colorcolumn=80
" Elimiate delay switching to normal mode
set timeoutlen=1000 ttimeoutlen=0
let mapleader = ","
nmap <F10> :set paste!<CR>
noremap <leader>n :set relativenumber!<cr>

" don't enter ex mode with Q
nnoremap Q <nop>
" Clear highlighted search results.
nnoremap <silent> <c-l> :noh<cr>

" backup to ~/.tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" this makes everything you do fuck with the system clipboard
"set clipboard=unnamedplus

noremap <leader>r :NERDTreeToggle<cr>
noremap <leader>e :TagbarToggle<cr>

noremap <leader>w :w<cr>
noremap <leader>z :st<cr>
"noremap <leader>tn :tabnew<cr>
"noremap <leader>tc :tabclose<cr>

map <leader>x <Plug>NERDCommenterToggle

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

" Use ag over grep
"set grepprg=ag\ --nogroup\ --nocolor
"set grepprg=git\ grep

" Searching
" global search prompt
nnoremap \ :Ag!<space>''<Left>
" global search for whole word under cursor
nnoremap \| :Ag! '\b<cword>\b'<CR>
" global search for word under cursor as text
nnoremap g\| :Ag! <cword><CR>
" global search for selection (<Esc> clears the range)
vnoremap \ <Esc>:Ag! '<C-r>*'<CR>

" search for selection
" Esc to clear the selection, then search for the last selected thing.
vnoremap * <Esc>/<C-r>*<CR>
vnoremap # <Esc>?<C-r>*<CR>

" mouse select and scroll
set mouse=a
" yank selection to system clipboard
vnoremap Y "+y
" yank line to system clipboard without trailing newline
nnoremap Y ^"+y$
" yank line to system clipboard
nnoremap YY "+yy
" paste from system clipboard
"nnoremap <C-v> "+p
nnoremap + O<Esc>"+p
" paste from system clipboard
"inoremap <C-S-v> "+p


" Shell command to generate ctags for ruby
"ctags -R --languages=ruby --exclude=.git --exclude=log .



"----------------------------------------------------------------------
" Plugins
"----------------------------------------------------------------------

" NERDTree
let g:nerdtree_tabs_open_on_gui_startup=0
"let NERDTreeSortOrder=[]

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
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['Gemfile', 'project.clj']
"let g:ctrlp_match_window_bottom = 0
"let g:ctrlp_match_window_reversed = 0
"let g:ctrlp_cmd = 'CtrlPMRU'
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden --smart-case -g ""'
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
let g:tagbar_sort = '0'


" utilsnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" gundo (undo-tree)
nnoremap <leader>g :GundoToggle<cr>


" gitgutter
"highlight clear SignColumn
highlight SignColumn ctermbg=bg
highlight GitGutterAdd ctermfg=darkgreen
highlight GitGutterChange ctermfg=darkyellow
highlight GitGutterDelete ctermfg=darkred
highlight GitGutterChangeDelete ctermfg=darkyellow


" auto-pairs
let g:AutoPairsShortcutFastWrap = '<C-a>'


" ag
let g:agprg="ag --nocolor --nogroup --column --hidden --smart-case --ignore log"


" syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
              \ 'active_filetypes': [],
              \ 'passive_filetypes': [] }


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
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
