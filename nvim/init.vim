set guicursor=a:block-blinkon1

call plug#begin('~/.local/share/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'
Plug 'jelera/vim-javascript-syntax'
Plug 'nemtsov/JavaScript-Indent'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'walm/jshint.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'plasticboy/vim-markdown'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'dart-lang/dart-vim-plugin'
Plug 'tpope/vim-fugitive'
Plug 'jsx/jsx.vim'
Plug 'justinmk/vim-sneak'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'terryma/vim-expand-region'
Plug 'cespare/vim-toml'
Plug 'airblade/vim-gitgutter'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-git'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Widdershin/sonic-pi-cli'
Plug 'digitaltoad/vim-jade'
Plug 'leafgarland/typescript-vim'
Plug 'Shougo/echodoc.vim'
Plug 'rust-lang/rust.vim'
Plug 'posva/vim-vue'
Plug 'raphael/vim-present-simple'
Plug 'google/vim-maktaba'
Plug 'google/vim-syncopate'
Plug 'google/vim-searchindex'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'vim-syntastic/syntastic'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins'  }
Plug 'Shougo/denite.nvim'
call plug#end()

autocmd VimResized * wincmd =
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let mapleader=" "

set history=1024

set number
set ignorecase
set tabstop=4
set shiftwidth=4
set showcmd
filetype plugin indent on

set background=dark
colorscheme solarized

let g:ctrlp_custom_ignore = {
			\	'dir': '\.git$\|node_modules\|assets'
			\ }

set list
exe "set listchars=tab:>-,trail:\xb7,eol:$,nbsp:\xb7"
set backspace=indent,eol,start
map <C-TAB> :set invlist<CR>
set invlist
au BufRead,BufNewFile *.es6 set filetype=javascript
au BufRead,BufNewFile *.es set filetype=javascript
au FileType json setlocal equalprg=python\ -m\ json.tool
autocmd BufReadPost *.rs setlocal filetype=rust
let g:session_autosave = 0
let g:vim_markdown_folding_disabled=1
let g:go_auto_sameids=0
let g:rustfmt_autosave=1
let g:deoplete#enable_at_startup = 1
set hidden

let g:LanguageClient_serverCommands = {
	\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
	\ }

let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()
nnoremap <silent> gd :call LanguageClient_textDocument_definition()
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()

au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>r <Plug>(go-rename)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
let g:go_fmt_command = "goimports"

au FileType rust let b:AutoPairs = {'(':')', '[':']', '{':'}',"<":">",'"':'"', '`':'`'}

au FileType ijm set syn=javascript " ImageJ Macro

map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
nmap <F8> :TagbarToggle<CR>
set mouse=a
syntax on

let g:airline_powerline_fonts = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
