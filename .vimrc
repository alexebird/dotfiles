set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

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
"Plugin 'airblade/vim-gitgutter'  " slow!
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-cucumber'
Plugin 'kien/ctrlp.vim'
Plugin 'slim-template/vim-slim'
Plugin 'techlivezheng/vim-plugin-minibufexpl'
Plugin 'kchmck/vim-coffee-script'
Plugin 'thoughtbot/vim-rspec'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'jnwhiteh/vim-golang'
Plugin 'majutsushi/tagbar'
Plugin 'elzr/vim-json'


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

set shell=/bin/bash
let &t_Co=256
set backspace=indent,eol,start
set encoding=utf-8

runtime macros/matchit.vim

syntax on

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
"imap iwi <C-[>:w<CR>
" don't enter ex mode with Q
nnoremap Q <nop>

" autosave
"set updatetime=800 " ms
"autocmd CursorHoldI,CursorHold,BufLeave <buffer> silent :update

" Tagbar
let g:tagbar_sort = '0'

