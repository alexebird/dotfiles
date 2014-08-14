set shell=/bin/bash
let &t_Co=256
set backspace=indent,eol,start
set encoding=utf-8

runtime macros/matchit.vim
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'
" vim-scripts repos
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
" Bundle 'file:///Users/gmarik/path/to/plugin'
" ...
"
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'bling/vim-airline'
Bundle 'taglist.vim'
"Bundle 'airblade/vim-gitgutter'  " slow!
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-cucumber'
Bundle 'kien/ctrlp.vim'
Bundle 'slim-template/vim-slim'
Bundle 'techlivezheng/vim-plugin-minibufexpl'
Bundle 'kchmck/vim-coffee-script'
Bundle 'thoughtbot/vim-rspec'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'jnwhiteh/vim-golang'
Bundle 'majutsushi/tagbar'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle 'honza/vim-snippets'
Bundle 'jiangmiao/auto-pairs'

filetype plugin indent on     " required!
syntax on

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set tabstop=4
set shiftwidth=4
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
" Clear highlighted search results.
nnoremap <silent> <c-l> :noh<cr>

set showcmd
set nowrap
set linebreak
set laststatus=2
" Elimiate delay switching to normal mode
set timeoutlen=1000 ttimeoutlen=0
let mapleader = ","
noremap <Leader>tt :MBEToggle<cr> :MBEFocus<cr>
noremap <Leader>r :NERDTreeToggle<cr>
noremap <Leader>e :TagbarToggle<cr>
"noremap <Leader>n :set number<cr>
"noremap <Leader>nn :set relativenumber<cr>

noremap <Leader>w :w<cr>
noremap <Leader>z :st<cr>
noremap <Leader>tn :tabnew<cr>
noremap <Leader>tc :tabclose<cr>

map <Leader>x <Plug>NERDCommenterToggle


" Don't move around in insert mode
"inoremap <up>    <nop>
"inoremap <down>  <nop>
"inoremap <left>  <nop>
"inoremap <right> <nop>

"syntax enable
let g:solarized_termcolors=256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
set background=dark
colorscheme solarized

autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby let g:rubycomplete_classes_in_global=1

" plugin: vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
" default section_z from https://github.com/bling/vim-airline/blob/master/autoload/airline/init.vim#L107
let g:airline_section_z = airline#section#create(['BN %{bufnr("%")} ', '%3p%% ', 'linenr', ':%3c '])

" plugin: ctrlp
let g:ctrlp_map = '<C-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['Gemfile']
let g:ctrlp_cmd = 'CtrlPMRU'

" plugin: miniBufExplorer
let g:miniBufExplorerAutoStart = 0

" Navigate through wrapped lines intuitively
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" Rspec mappings
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

" esc and write file from insert mode
imap iwi <C-[>:w<CR>

" autosave
"set updatetime=800 " ms
"autocmd CursorHoldI,CursorHold,BufLeave <buffer> silent :update

" Tagbar
let g:tagbar_sort = '0'

