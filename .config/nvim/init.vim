"
"  __     ___
"  \ \   / (_)_ __ ___
"   \ \ / /| | '_ ` _ \
"    \ V / | | | | | | |
"     \_/  |_|_| |_| |_| v2
"
"
" alexebird@gmail.com
" created 2022/03/15
"
"


lua require('impatient')
lua require('plugins')

" required for vim-textobj-rubyblock
"runtime macros/matchit.vim

set shell=/bin/bash
set backspace=indent,eol,start

set nocompatible
filetype plugin indent on
syntax on
syntax enable

set background=dark
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
set wildmenu
set wildmode=longest:full,full
set synmaxcol=1000 " Avoids editor lockup in files with extremely long lines."
set listchars=eol:$
set termguicolors
"set autowriteall  " <---- huh??
"set colorcolumn=80
" Elimiate delay switching to normal mode
"set timeoutlen=500 ttimeoutlen=0

" leader
let mapleader = ","
nnoremap <Space> <Nop>
let maplocalleader=" "
set completeopt=menu,menuone,noselect

" backup to ~/.tmp
" disabled for coc
"set backup
"set backupdir=~/tmp,/tmp
"set backupskip=/tmp/*,/private/tmp/*
"set directory=~/tmp,/tmp
"set writebackup
" for coc.vim
"set nobackup
"set nowritebackup

" mouse select and scroll
set mouse=a

noremap <leader>. :wa<cr>

" clear highlighted search results.
nnoremap <silent> <c-l> :noh<cr>

" don't advance when searching with *
nnoremap <silent> <Leader>* :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap * :keepjumps normal! mi*`i<CR>
" search for selection
" Esc to clear the selection, then search for the last selected thing.
vnoremap * "9y<Esc>/<C-r>9<CR>
vnoremap # "9y<Esc>?<C-r>9<CR>

command! SS source $MYVIMRC
command! SV edit ~/.config/nvim/init.vim
command! FW FixWhitespace

noremap <leader>r :NvimTreeToggle<cr>

" resize windows faster
nnoremap <C-w>, <C-w>10<
nnoremap <C-w>. <C-w>10>

" readline emulation
inoremap <C-d> <Del>
inoremap <C-t> <Esc>xpa
inoremap <C-b> <Left>
vnoremap <C-b> <Left>
inoremap <C-f> <Right>
vnoremap <C-f> <Right>
inoremap <C-a> <Esc>^i
inoremap <C-e> <Esc>$a

" Navigate through wrapped lines intuitively
imap <silent> <down> <c-o>gj
imap <silent> <up> <c-o>gk
nmap <silent> <down> gj
nmap <silent> <up> gk
nmap <silent> j gj
nmap <silent> k gk

" close quickfix
nnoremap <leader>a :cclose<cr>

" nnoremap <F1> <nop>
" inoremap <F1> <nop>

" Normal mode
nnoremap <F1> <Esc>
" Insert and Replace mode
inoremap <F1> <Esc>
" Visual and Select mode
vnoremap <F1> <Esc>
" Visual mode
xnoremap <F1> <Esc>
" Select mode
snoremap <F1> <Esc>
" Command-line mode
cnoremap <F1> <Esc>
" Operator pending mode
onoremap <F1> <Esc>


"-------------------------------------------------------------
" custom functions
"-------------------------------------------------------------
function! PutsDate()
    put =strftime('# %c')
endfunction
command! Date call PutsDate()


"-------------------------------------------------------------
" filetype adjustments
"-------------------------------------------------------------
" autocmd Filetype sh             setlocal et ts=2 sw=2 sts=2 iskeyword+=:
" autocmd Filetype bash           setlocal et ts=2 sw=2 sts=2 iskeyword+=:
" autocmd Filetype terraform      setlocal et ts=2 sw=2 sts=2
" autocmd Filetype json           setlocal et ts=2 sw=2 sts=2
" autocmd Filetype javascript     setlocal et ts=2 sw=2 sts=2
" autocmd Filetype yaml           setlocal et ts=2 sw=2 sts=2
" autocmd Filetype html           setlocal et ts=2 sw=2 sts=2
" autocmd Filetype css            setlocal et ts=2 sw=2 sts=2

autocmd FileType eruby setlocal commentstring=<!--\ %s\ -->

autocmd BufNewFile,BufRead *.tf         set ft=terraform
autocmd BufNewFile,BufRead *.tfvars     set ft=terraform
autocmd BufWritePre *.js Neoformat

let g:extra_whitespace_ignored_filetypes = ['TelescopePrompt']


"-------------------------------------------------------------
" clipboard
"-------------------------------------------------------------
" yank selection to system clipboard
vnoremap Y "+y
" yank line to system clipboard without trailing newline
nnoremap Y ^"+y$
" yank line to system clipboard
nnoremap YY "+yy
" paste from system clipboard
nnoremap + "+p

function! CopyFilnameToClipboard()
    let @+=@%
    execute 'file'
endfunction

"nnoremap <silent> <C-c> :call CopyFilnameToClipboard()<CR>
command! CopyFname call CopyFilnameToClipboard()

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <C-j> <cmd>Telescope buffers<cr>
" nnoremap <C-j> <cmd>Telescope oldfiles only_cwd=true<cr>
" nnoremap <C-j> <cmd>lua require('telescope.builtin').oldfiles({only_cwd=true})<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"-------------------------------------------------------------
" searching
"-------------------------------------------------------------
" global search prompt
nnoremap \ :Rg ''<Left>
" global search for whole word under cursor using '|' character
nnoremap <bar> :Rg '\b<cword>\b'<CR>
" global search for word under cursor as text (with no word boundary)
" nnoremap g\ :Rg <cword><CR>
" global search for selection (<Esc> clears the range)
vnoremap \ "9y<Esc>:Rg '<C-r>9'<CR>

" if executable('ag')
"   let g:ackprg = 'ag --vimgrep --hidden --smart-case --skip-vcs-ignores'
" endif

" search for selection
" Esc to clear the selection, then search for the last selected thing.
vnoremap * "9y<Esc>/<C-r>9<CR>
vnoremap # "9y<Esc>?<C-r>9<CR>


lua require('personal')


" let g:purify_override_colors = {
"     \ 'comment_grey':  { 'gui': '#FFFFFF', 'cterm': 162 },
"     \ 'gutter_grey_fg':  { 'gui': '#FFFFFF', 'cterm': 243 }
" \ }
" highlight Visual cterm=bold ctermfg=white ctermbg=26 " 26 blue
" highlight Search cterm=NONE ctermfg=black ctermbg=226 " 226 yellow
" highlight SpellBad cterm=bold ctermfg=white ctermbg=1 " 1 red
