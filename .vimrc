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
Plugin 'vim-scripts/JavaScript-Indent'
Plugin 'marijnh/tern_for_vim' " JavaScript autocomplete
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'walm/jshint.vim'
Plugin 'bling/vim-airline'
Plugin 'spf13/vim-autoclose'
Plugin 'plasticboy/vim-markdown'
Plugin 'spf13/PIV'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'MarcWeber/vim-addon-local-vimrc'
Plugin 'tpope/vim-haml' " SASS support
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'wting/rust.vim'
Plugin 'vim-erlang/vim-erlang-runtime'
Plugin 'vim-erlang/vim-erlang-compiler'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'vim-erlang/vim-erlang-tags'
Plugin 'jsx/jsx.vim'
Bundle 'justinmk/vim-sneak'
call vundle#end()

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

set list
exe "set listchars=tab:>-,trail:\xb7,eol:$,nbsp:\xb7" 
set backspace=indent,eol,start
map <C-TAB> :set invlist<CR>
set invlist

au BufRead,BufNewFile *.go set syntax=go
au FileType json setlocal equalprg=python\ -m\ json.tool

set completeopt=longest,menuone
set encoding=utf-8
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
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

au FileType ijm set syn=javascript " ImageJ Macro

let g:go_fmt_command = "goimports"
"autocmd vimenter * if !argc() | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"let g:nerdtree_tabs_open_on_console_startup = 1
map <Leader>n <plug>NERDTreeTabsToggle<CR>
"let g:airline_theme='solarized'
"let g:airline_solarized_bg='dark'
let g:airline_theme='dark'
nmap <F8> :TagbarToggle<CR>
set mouse=a

syntax on
set nofoldenable

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
