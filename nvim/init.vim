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

" Searching/Fuzzyfind
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-key-bindings --no-completion --update-rc' }
Plug 'junegunn/fzf.vim'

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

set hidden							" Enable automatic hiding of buffers even when they are modified

set laststatus=2					" Always display statusline
set ttimeoutlen=0

set number							" turn on line numbers
set numberwidth=5					" We are good up to 9999 lines
set listchars=tab:▸\ ,eol:$,nbsp:%	" change the tab and eol characters

set autochdir						" always switch to the current file directory
set wrapscan						" searches wrap around the end of the buffer
set ignorecase						" case insensitive searches
set smartcase						" if there are caps, go case-sensitive
set incsearch						" show match for partly typed searches
set hlsearch						" highlight all matches for the last used search pattern
set inccommand=split				" interactive search-and-replace

set nowrap							" do not wrap lines

set cursorline						" highlight current line

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
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" Colorscheme
set termguicolors					" Enable 24 bit colors
colorscheme jellybeans

" Silver Searcher ag.vim
let g:ag_working_path_mode="r" " start search in project root

" Font selection for GUI
if has('gui')
	set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 9
endif

" match lines containing todos regardless if filetype highlights differently
augroup HighlightTodos
    autocmd!
    autocmd WinEnter,VimEnter * highlight ToDoLine ctermbg=red guibg=#ff00ff guifg=#222222
    autocmd WinEnter,VimEnter * call matchadd('ToDoLine', '^.*(TODO|FIXME).*$', -1)
augroup END

" match extra whitespace at the end of lines
augroup HighlightExtraWhitespace
    autocmd!
    autocmd WinEnter,VimEnter * highlight ExtraWhitespace ctermbg=red guibg=#ff00ff
    autocmd WinEnter,VimEnter * call matchadd('ExtraWhitespace', '\s\+$', -1)
augroup END

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
let mapleader = ","

noremap <silent> <C-k> :call <SID>swap_up()<CR>
noremap <silent> <C-j> :call <SID>swap_down()<CR>

" Fix F1/DEL issue
nmap <F1> <Nop>
imap <silent> <F1> <Del>

" Buffer management
nmap <silent> <Leader>T :enew<CR>
nmap <silent> <Leader>bq :bprevious <Bar> bdelete! #<CR>
nmap <silent> <Leader>bk :bdelete!<CR>
nmap <silent> gb :bnext<CR>
nmap <silent> gB :bprevious<CR>

" FuzzyFind
nmap <silent> <Leader>fg :GFiles<CR>
nmap <silent> <Leader>ff :Files<CR>
nmap <silent> <Leader>fb :Buffers<CR>
nmap <silent> <Leader>fc :Commits<CR>
nmap <silent> <Leader>fll :Lines<CR>
nmap <silent> <Leader>flb :BLines<CR>

" Remove trailing whitespace
nmap <silent> <Leader>w :silent! %s/\s\+$//<CR>

" Show/hide whitespace (except space)
nmap <silent> <F12> :set list!<CR>

nmap <silent> <Leader>h :SemanticHighlightToggle<CR>

" Key mappings to edit/reload config files
nmap <silent> <Leader>s :w <Bar> source ~/.config/nvim/init.vim<CR>
nmap <silent> <Leader>v :e ~/.config/nvim/init.vim<CR>
nmap <silent> <Leader>f :e ~/.config/fish/config.fish<CR>

" Copy/Paste
vnoremap <silent> <Leader>y "+y<CR>
nnoremap <silent> <Leader>p "+gP<CR>

" silver searcher (through fzf)
nnoremap <Leader>ag :Ag<Space>
nnoremap <Leader>ac :Ag <C-r><C-w><CR>

" Save as root if forgotten to start with sudo
cmap w!! w !sudo tee % > /dev/null

" Force use of tabs
" cab e tabe

