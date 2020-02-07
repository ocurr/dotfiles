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

set backspace=indent,eol,start

set mouse=a

set autoread

au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! noautocmd w

let g:solarized_termtrans=1
let g:solarized_termcolors=256
set background=dark
if !empty(glob("~/.vim/colors/solarized.vim"))
    colorscheme solarized
else
    colorscheme desert
endif

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
Plug 'altercation/vim-colors-solarized', { 'do': 'test -d ../../colors \|\| mkdir ../../colors && cp colors/solarized.vim ../../colors/.' }
Plug 'danro/rename.vim'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'cespare/vim-toml'
Plug 'toyamarinyon/vim-swift', { 'for': 'swift' }
Plug 'jamshedvesuna/vim-markdown-preview'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

call plug#end()

let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=0

command! MarkdownPandoc let vim_markdown_preview_pandoc=1 | let vim_markdown_preview_github=0 | call Vim_Markdown_Preview()
command! MarkdownGithub let vim_markdown_preview_pandoc=0 | let vim_markdown_preview_github=1 | call Vim_Markdown_Preview()

map mp :call Vim_Markdown_Preview()<CR>

map ntr :NERDTreeToggle<CR>
