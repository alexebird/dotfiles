"  __     ___
"  \ \   / (_)_ __ ___
"   \ \ / /| | '_ ` _ \
"    \ V / | | | | | | |
"     \_/  |_|_| |_| |_|  alexebird@gmail.com
"
call plug#begin('~/.config/nvim/plugged')

" core
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-sleuth'
"Plug 'scrooloose/syntastic'
"Plug 'ervandew/supertab'
"Plug 'vim-scripts/taglist.vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " github extension for fugitive

" coloring
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'jiangmiao/auto-pairs'
"Plug 'andreasvc/vim-256noir'
"Plug 'altercation/vim-colors-solarized'

" tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jamessan/vim-gnupg'
Plug 'chr4/nginx.vim'
Plug 'chr4/sslsecure.vim'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'SirVer/ultisnips'

" textobjs
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" motion mods
Plug 'Lokaltog/vim-easymotion'

" Language Server Protcol
Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'
Plug 'Shougo/ddc-around'
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'

" langs - general
Plug 'lmeijvogel/vim-yaml-helper'
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-terraform'
Plug 'keith/swift.vim'
"Plug 'dleonard0/pony-vim-syntax'
"Plug 'rust-lang/rust.vim'

" langs - ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'slim-template/vim-slim'

" langs - clj
"Plug 'guns/vim-clojure-highlight'
"Plug 'guns/vim-clojure-static'
"Plug 'guns/vim-sexp'
"Plug 'tpope/vim-sexp-mappings-for-regular-people'
"Plug 'tpope/vim-fireplace'

" langs - elixir
"Plug 'elixir-lang/vim-elixir'
"Plug 'slime-lang/vim-slime-syntax'

" langs - golang
"Plug 'fatih/vim-go'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"-------------------------------------------------------------
" begin vim configuration
"-------------------------------------------------------------
" required for vim-textobj-rubyblock
runtime macros/matchit.vim

set shell=/bin/bash
set backspace=indent,eol,start

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
set synmaxcol=300 " Avoids editor lockup in files with extremely long lines."
set listchars=eol:$
"set autowriteall  " <---- huh??
"set colorcolumn=80
" Elimiate delay switching to normal mode
"set timeoutlen=500 ttimeoutlen=0

let mapleader = ","
nnoremap <Space> <Nop>
let maplocalleader=" "

" see coc.vim readme
"set cmdheight=2
"set updatetime=300
"set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
  "" Recently vim can merge signcolumn and number column into one
  "set signcolumn=number
"else
  "set signcolumn=yes
"endif

" backup to ~/.tmp
" disabled for coc
"set backup
"set backupdir=~/tmp,/tmp
"set backupskip=/tmp/*,/private/tmp/*
"set directory=~/tmp,/tmp
"set writebackup
set nobackup
set nowritebackup

" mouse select and scroll
set mouse=a

"-------------------------------------------------------------
" colorscheme
"-------------------------------------------------------------
" some tools when working with colors:
"
"for i in {0..255} ; do
    "printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    "if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
        "printf "\n";
    "fi
"done
"runtime syntax/colortest.vim

"colorscheme 256_noir
let g:purify_override_colors = {
    \ 'comment_grey':  { 'gui': '#FFFFFF', 'cterm': 162 },
    \ 'gutter_grey_fg':  { 'gui': '#FFFFFF', 'cterm': 243 }
\ }
colorscheme purify
highlight Visual cterm=bold ctermfg=white ctermbg=26 " 26 blue
highlight Search cterm=NONE ctermfg=black ctermbg=226 " 226 yellow
highlight SpellBad cterm=bold ctermfg=white ctermbg=1 " 1 red

"-------------------------------------------------------------
" mappings
"-------------------------------------------------------------
noremap <leader>n :set relativenumber!<cr>

" don't enter ex mode with Q
"nnoremap Q <nop>
" clear highlighted search results.
nnoremap <silent> <c-l> :noh<cr>
" don't advance when searching with *
"nnoremap * m`:keepjumps normal! *``<cr>
nnoremap <silent> * :let @/='\<<C-r>=expand("<cword>")<cr>\>'<cr>:set hls<cr>

command! SS source $MYVIMRC
command! SV edit ~/.config/nvim/init.vim

noremap <leader>r :NERDTreeToggle<cr>
noremap <leader>e :TagbarToggle<cr>
map <leader>x <Plug>NERDCommenterToggle

noremap <leader>. :wa<cr>
"noremap <leader>z :st<cr>

" resize windows faster
nnoremap <C-w>, <C-w>10<
nnoremap <C-w>. <C-w>10>

" readline nice-to-haves
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
" ruby
"autocmd FileType ruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby let g:rubycomplete_buffer_loading=1
"autocmd FileType ruby let g:rubycomplete_classes_in_global=1
"autocmd Filetype ruby setlocal et ts=2 sw=2 sts=2

"autocmd FileType sh             setlocal shiftwidth=4 softtabstop=4 expandtab
"autocmd FileType bash           setlocal sw=4 sts=4 et
"autocmd Filetype terraform      setlocal et ts=2 sw=2 sts=2
"autocmd Filetype bash           setlocal et ts=2 sw=2 sts=2 iskeyword+=:
"autocmd Filetype sh             setlocal et ts=2 sw=2 sts=2 iskeyword+=:
"autocmd Filetype json           setlocal et ts=2 sw=2 sts=2
"autocmd Filetype javascript     setlocal et ts=2 sw=2 sts=2
"autocmd Filetype yaml           setlocal et ts=2 sw=2 sts=2
"autocmd Filetype crystal        setlocal et ts=2 sw=2 sts=2
"autocmd Filetype html           setlocal et ts=2 sw=2 sts=2
"autocmd Filetype css            setlocal et ts=2 sw=2 sts=2

"autocmd BufRead,BufNewFile *.md set filetype=markdown
"autocmd BufRead,BufNewFile *.hcl setlocal ft=terraform et ts=2 sw=2 sts=2
"autocmd BufRead,BufNewFile *.hcl.tmpl setlocal ft=terraform et ts=2 sw=2 sts=2
"autocmd BufRead,BufNewFile *.hcl.mustache setlocal ft=terraform.mustache et ts=2 sw=2 sts=2
"autocmd BufRead,BufNewFile *.yml.ctmpl  setlocal ft=yaml.mustache et ts=2 sw=2 sts=2
"autocmd BufRead,BufNewFile *.conf.ctmpl setlocal ft=conf.mustache et ts=2 sw=2 sts=2

"autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal nonumber | endif

"autocmd CmdwinEnter * :setlocal nonumber
"autocmd CmdwinLeave * :setlocal number

"-------------------------------------------------------------
" searching
"-------------------------------------------------------------
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

nnoremap <silent> <C-c> :call CopyFilnameToClipboard()<CR>

"----------------------------------------------------------------------
" plugins
"----------------------------------------------------------------------

" NERDTree
let g:nerdtree_tabs_open_on_gui_startup=0
let g:NERDTreeIgnore = ['^__pycache__$', '^.*\.pyc$']
let NERDTreeShowBookmarks=1
let g:NERDTreeBookmarksFile='./.NERDTreeBookmarks'

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
" default section_z from https://github.com/bling/vim-airline/blob/master/autoload/airline/init.vim#L107
let g:airline_section_z = airline#section#create(['%p%%', 'linenr', ':%c'])
let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='purify'

" ctrlp
let g:ctrlp_map = '<C-p>'
let g:ctrlp_working_path_mode = 'r'
"let g:ctrlp_root_markers = []
let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden --smart-case --skip-vcs-ignores -g ""'
" overcome limit imposed by max height
"let g:ctrlp_match_window = 'results:50'
" ag is fast enough that CtrlP doesn't need to cache
"let g:ctrlp_use_caching = 1
"let g:ctrlp_mruf_relative = 1
let g:ctrlp_mruf_exclude = '/tmp/.*\|\.git/.*|\.pyc$'
nnoremap <C-h> :CtrlPTag<CR>
nnoremap <C-j> :CtrlPMRU<CR>
nnoremap <C-k> :CtrlPBuffer<CR>

" gitgutter
highlight GitGutterAdd ctermfg=darkgreen
highlight GitGutterChange ctermfg=darkyellow
highlight GitGutterDelete ctermfg=darkred
highlight GitGutterChangeDelete ctermfg=darkyellow
command! GR GitGutterUndoHunk

" auto-pairs
let g:AutoPairsShortcutFastWrap = '<C-s>'
let g:surround_no_insert_mappings = 1

" syntastic
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': ['python'] }
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_sh_checkers = ['shellcheck']

" easymotion
let g:EasyMotion_do_mapping = 0 " disable default mappings
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

" supertab
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabCrMapping = 1
"let g:SuperTabDefaultCompletionType = "<c-n>"

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
"let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=0

" rainbowparens
let g:rainbow#blacklist = [0, 7, 8,
      \ 232, 233, 234, 235, 236, 237,
      \ 238, 239, 240, 241, 242, 243,
      \ 244, 245, 246, 247, 248, 249,
      \ 250, 251, 252, 253, 254, 255
  \ ]
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd FileType * RainbowParentheses


"----------------------------------------------------------------------
" vim-go golang
"----------------------------------------------------------------------
" jump around to go errors
"map <C-b> :cprevious<cr>
"map <C-n> :cnext<cr>

"let g:go_def_mode='gopls'
"let g:go_info_mode='gopls'

"" run goimports upon save
"let g:go_fmt_command = "gopls"
"let g:go_gopls_gofumpt=1

"let g:go_rename_command = 'gopls'
"let g:go_list_type = "quickfix"

"" shortcut to for go build
"autocmd FileType go nmap <leader>b  <Plug>(go-build)

"" Automatically get signature/type info for object under cursor
"let g:go_auto_type_info = 1

"" syntax highlighting
"let g:go_highlight_functions = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_extra_types = 1
"let g:go_highlight_operators = 1

" auto-open omnifunc when you type a period.
"au filetype go inoremap <buffer> . .<C-x><C-o>


" Swift
let g:NERDCustomDelimiters = { 'swift': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' } }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language Server Stuff

" Errors in Red
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" Warnings in Yellow
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" Info and Hints in White
hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White

" Underline the offending code
hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  vim.lsp.set_log_level("debug")

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'solargraph', 'tsserver', 'bashls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = false,
   -- Enable virtual text only on Warning or above, override spacing to 2
   virtual_text = {
     spacing = 2,
     severity_limit = "Warning",
   },
 }
)
EOF

" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })

" Change source options
"call ddc#custom#patch_global('sourceOptions', {
      "\ 'around': {'mark': 'A'},
      "\ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

" Customize settings on a filetype
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
      "\ 'clangd': {'mark': 'C'},
      "\ })
"call ddc#custom#patch_filetype('markdown', 'sourceParams', {
      "\ 'around': {'maxSize': 100},
      "\ })

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()

" End Language Server Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------
" coc.vim (old language server attempt)
" colors for error popup
"hi default CocFloating ctermfg=Red ctermbg=White

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
"let g:go_def_mapping_enabled = 0

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use <c-space> to trigger completion.
"if has('nvim')
  "inoremap <silent><expr> <c-space> coc#refresh()
"else
  "inoremap <silent><expr> <c-@> coc#refresh()
"endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              "\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "elseif (coc#rpc#ready())
    "call CocActionAsync('doHover')
  "else
    "execute '!' . &keywordprg . " " . expand('<cword>')
  "endif
"endfunction

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"augroup mygroup
  "autocmd!
  "" Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  "" Update signature help on jump placeholder.
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
  "nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  "nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  "inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  "inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  "vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  "vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif

"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')

"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" end coc.vim
"-------------------------------------------------------------
