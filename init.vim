syntax on
filetype plugin indent on
set expandtab
set ts=4
set shiftwidth=4
set number
set autoindent
set wildmenu
set switchbuf=usetab,newtab
set ruler
set nohlsearch

set mouse=a

let g:solarized_termtrans=1
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Common indentation modes
" Sets the indentation options to common settings.
" Usage: :Tabs 8
"        :Spaces 3
"        :Tabs      " same as Tabs 8
"        :Spaces    " same as Spaces 4
" Full credit to Ross Light for this code
" see his full configuration at
" https://bitbucket.org/zombiezen/vimrc/overview 
command! -bar -count=8 Tabs set ts=<count> sts=0 sw=<count> noet
command! -bar -count=4 Spaces set ts=8 sts=<count> sw=<count> et

" go configuration
let go_highlight_array_whitespace_error = 0

" Plugins
call plug#begin()

Plug 'https://github.com/scrooloose/nerdtree.git', { 'on': 'NERDTreeToggle' }
Plug 'https://github.com/fatih/vim-go.git', { 'for': 'go' }
Plug 'https://github.com/peter-edge/vim-capnp.git', { 'for': 'capnp' }
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'danro/rename.vim'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'cespare/vim-toml'

call plug#end()

map ntr :NERDTreeToggle<CR>
