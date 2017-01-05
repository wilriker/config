" Prevent issues with non-bourne-shells
if $SHELL =~ 'bin/zsh'
	set shell=/bin/bash
endif
if $SHELL =~ 'bin/fish'
	set shell=/bin/bash
endif

" Make sure vim-plug is installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" initialize vim-plug
call plug#begin('~/.vim/plugged')

" Code formatting
Plug 'tpope/vim-endwise'

" Other stuff
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
"Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdtree',			{ 'on':  'NERDTreeToggle' }
Plug 'rking/ag.vim'

" Color schemes
Plug 'nanotech/jellybeans.vim'
"Plug 'godlygeek/csapprox'
Plug 'ap/vim-css-color'
Plug 'jaxbot/semantic-highlight.vim'

" Filetype plugin
Plug 'wilriker/vim-fish',			{ 'for':  'fish' }
Plug 'tfnico/vim-gradle',			{ 'for':  'groovy' }
Plug 'wilriker/systemd-vim-syntax',	{ 'for' : 'systemd' }
Plug 'wilriker/udev-vim-syntax',	{ 'for' : 'udev' }
Plug 'kchmck/vim-coffee-script',	{ 'for' : 'coffee' }

" All of your Plugins must be added before the following line
call plug#end()						" Add plugins to &runtimepath

" Working directories
set dir=~/tmp,/tmp,/var/tmp,.

set laststatus=2
set timeoutlen=1000
set ttimeoutlen=0

set number							" turn on line numbers
set numberwidth=4					" We are good up to 9999 lines
set listchars=tab:▸\ ,eol:$,nbsp:%	" change the tab and eol characters

set autochdir						" always switch to the current file directory
set wrapscan						" searches wrap around the end of the buffer
set ignorecase						" case insensitive searches
set smartcase						" if there are caps, go case-sensitive
set incsearch						" show match for partly typed searches
set hlsearch						" highlight all matches for the last used search patter
set inccommand=split				" interactive search-and-replace

set nowrap							" do not wrap lines

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

" Silver Searcher ag.vim
nnoremap <leader>ag :Ag
nnoremap <leader>ac :Ag <C-r><C-w><CR>
let g:ag_working_path_mode="r" " start search in project root

" Font selection for GUI
if has('gui')
	set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 9
endif

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/		" match trailing whitespaces

" Functions
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
let mapleader = "-"

noremap <silent> <C-k> :call <SID>swap_up()<CR>
noremap <silent> <C-j> :call <SID>swap_down()<CR>

" Fix F1/DEL issue
nmap <F1> <Nop>
imap <silent> <F1> <DEL>

nmap <silent> <F2> :NERDTreeToggle<CR>
" Remove trailing whitespace
nmap <silent> <leader>w :silent! %s/\s\+$//<CR>
" Show/hide whitespace (except space)
nmap <silent> <F12> :set list!<CR>
nmap <silent> <leader>h :SemanticHighlightToggle<CR>

" Key mappings to edit/reload config files
nmap <silent> <leader>s :w<CR>:source ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>v :tabe ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>f :tabe ~/.config/fish/config.fish<CR>

" Copy/Paste
vnoremap <silent> <leader>y "+y<CR>
nnoremap <silent> <leader>p "+gP<CR>

" Save as root if forgotten to start with sudo
cmap w!! w !sudo tee % > /dev/null

" Force use of tabs
cab e tabe

