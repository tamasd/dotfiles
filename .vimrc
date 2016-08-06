set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'SirVer/ultisnips'
Plugin 'majutsushi/tagbar'
Plugin 'Shougo/neocomplete.vim'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'nemtsov/JavaScript-Indent'
Plugin 'marijnh/tern_for_vim' " JavaScript autocomplete
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'walm/jshint.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mattn/webapi-vim'
"Plugin 'Wildog/airline-weather.vim'
Plugin 'spf13/vim-autoclose'
Plugin 'plasticboy/vim-markdown'
Plugin 'spf13/PIV'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'tpope/vim-haml' " SASS support
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-erlang/vim-erlang-runtime'
Plugin 'vim-erlang/vim-erlang-compiler'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'vim-erlang/vim-erlang-tags'
Plugin 'jsx/jsx.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'terryma/vim-expand-region'
Plugin 'cespare/vim-toml'
Plugin 'airblade/vim-gitgutter'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-git'
Plugin 'othree/yajs.vim'
Plugin 'othree/es.next.syntax.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Widdershin/sonic-pi-cli'
Plugin 'digitaltoad/vim-jade'
Plugin 'leafgarland/typescript-vim'
Plugin 'Shougo/echodoc.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
call vundle#end()

augroup VimCSS3Syntax
	autocmd!

	autocmd FileType css setlocal iskeyword+=-
augroup END

let mapleader=" "

set history=1024

if has("gui_running")
	set guifont=Menlo:h12
endif
set number
set ignorecase
set tabstop=4
set shiftwidth=4
filetype plugin indent on

set background=dark
colorscheme solarized

let g:weather#area = 'szeged,hu'
let g:weather#unit = 'metric'
let g:weather#appid = 'c825dd4c4ab277a8813fa72ce85d0654'

let g:ctrlp_custom_ignore = {
			\	'dir': '\.git$\|node_modules\|assets'
			\ }

set list
exe "set listchars=tab:>-,trail:\xb7,eol:$,nbsp:\xb7" 
set backspace=indent,eol,start
map <C-TAB> :set invlist<CR>
set invlist

au BufRead,BufNewFile *.go set syntax=go
au BufRead,BufNewFile *.es6 set filetype=javascript
au BufRead,BufNewFile *.es set filetype=javascript
au FileType json setlocal equalprg=python\ -m\ json.tool

set completeopt=longest,menuone
set encoding=utf-8
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd filetype crontab setlocal nobackup nowritebackup
let g:racer_experimental_completer = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:go_snippet_engine = "neosnippet"
let g:session_autosave = 0
let g:vim_markdown_folding_disabled=1
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>r <Plug>(go-rename)
au WinEnter * set nofen
au WinLeave * set nofen
au FileType * set nofen

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

au FileType ijm set syn=javascript " ImageJ Macro

let g:go_fmt_command = "goimports"
"autocmd vimenter * if !argc() | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"let g:nerdtree_tabs_open_on_console_startup = 1
map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
nmap <F8> :TagbarToggle<CR>
set mouse=a

syntax on
set nofoldenable

set autoread

let g:airline_powerline_fonts = 1

if &term =~ '256color'
	set t_ut=
endif

map <Esc>Oq 1
map <Esc>Or 2
map <Esc>Os 3
map <Esc>Ot 4
map <Esc>Ou 5
map <Esc>Ov 6
map <Esc>Ow 7
map <Esc>Ox 8
map <Esc>Oy 9
map <Esc>Op 0
map <Esc>On .
map <Esc>OQ /
map <Esc>OR *
map <Esc>Ol +
map <Esc>OS -
map <Esc>OM <Enter>
map! <Esc>Oq 1
map! <Esc>Or 2
map! <Esc>Os 3
map! <Esc>Ot 4
map! <Esc>Ou 5
map! <Esc>Ov 6
map! <Esc>Ow 7
map! <Esc>Ox 8
map! <Esc>Oy 9
map! <Esc>Op 0
map! <Esc>On .
map! <Esc>OQ /
map! <Esc>OR *
map! <Esc>Ol +
map! <Esc>OS -
map! <Esc>OM <Enter>
