" Prevent issues with non-bourne-shells
if $SHELL =~ 'bin/zsh'
	set shell=/bin/bash
endif
if $SHELL =~ 'bin/fish'
	set shell=/bin/bash
endif

set nocompatible					" Use Vim defaults instead of 100% vi compatibility
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
"Plugin 'edkolev/tmuxline.vim'
Plugin 'tfnico/vim-gradle.git'

Plugin 'scrooloose/nerdtree.git'

" Color schemes
Plugin 'nanotech/jellybeans.vim'
"Plugin 'godlygeek/csapprox'
Plugin 'dag/vim-fish'

Plugin 'ap/vim-css-color'
" All of your Plugins must be added before the following line
call vundle#end()					" required
filetype plugin indent on			" required

" Working directories
set dir=~/tmp,/tmp,/var/tmp,.

if !has('nvim')
	set t_Co=256					" allow the usage of 256 colors
endif
syntax on							" turn syntax highlighting on
set laststatus=2
set timeoutlen=1000
set ttimeoutlen=0

set number							" turn on line numbers
set numberwidth=4					" We are good up to 9999 lines
set listchars=tab:>-,eol:$,nbsp:%	" change the tab and eol characters

set autochdir						" always switch to the current file directory
set wrapscan						" searches wrap around the end of the buffer
set ignorecase						" case insensitive searches
set smartcase						" if there are caps, go case-sensitive
set incsearch						" show match for partly typed searches
set hlsearch						" highlight all matches for the last used search patter

set nowrap							" do not wrap lines

if !has('nvim')
	set mouse=a						" Use the mouse
	set ttymouse=xterm2				" Use this setting in terminal 'st'
endif

set cursorline						" highlight current line
set nospell							" disable spell checking

set splitright						" a new window is put right of the current one

set showcmd							" show the command being typed
set noerrorbells					" don't ring the bell for error messages
set title							" show info in the window title
set noshowmode						" don't show the current mode in status line (airline already has it)

set undolevels=1000					" maximum number of changes that can be undone
set backspace=indent,eol,start		" make backspace more flexible
set showmatch						" show matching brackets
set matchpairs+=<:>					" define the matching brackets
au FileType c,cpp,java set mps+==:;	" Set a pair for assignments in Java and C/C++

"	15 tabs and indenting
set tabstop=4						" make tabs 4 characters wide
set shiftwidth=4					" make whitespace indentation 4 characters wide
set nosmarttab						" don't insert spaces for <TAB> in indentations
set softtabstop=4					" make expanded tabs 4 characters wide
set noexpandtab						" do not expand tabs to single whitespaces

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Colorscheme
colorscheme jellybeans

" Font selection for GUI
if has('gui')
	set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 9
endif

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/	   " match trailing whitespaces

" Functions
function! RemoveTrailingWhitespace()
	:silent! %s/\s\+$//
endfunction

function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

" Custom key mappings
noremap <silent> <C-k> :call <SID>swap_up()<CR>
noremap <silent> <C-j> :call <SID>swap_down()<CR>
nmap <F1> <Nop>
if has('nvim')
	imap <silent> <F1> <DEL>
endif
nmap <silent> <F2> :NERDTreeToggle<CR>
nmap <silent> <F11> :call RemoveTrailingWhitespace()<CR>
nmap <silent> <F12> :set list!<CR>
if !has('nvim')
	set pastetoggle=<F12>
endif

" Key mappings to edit/reload config files
if has('nvim')
	nmap ,s :w<CR>:source ~/.config/nvim/init.vim<CR>
	nmap ,v :tabe ~/.config/nvim/init.vim<CR>
else
	nmap ,s :w<CR>:source ~/.vimrc<CR>
	nmap ,v :tabe ~/.vimrc<CR>
endif
nmap ,z :tabe ~/.zshrc<CR>

" Force use of tabs
cab e tabe

