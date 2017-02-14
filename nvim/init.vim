" Prevent issues with non-bourne-shells
"if $SHELL =~ 'bin/zsh'
"	set shell=/bin/bash
"endif
"if $SHELL =~ 'bin/fish'
"	set shell=/bin/bash
"endif

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
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdcommenter'

" Other stuff
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'edkolev/tmuxline.vim'
Plug 'schickling/vim-bufonly'

" Navigation
Plug 'rhysd/clever-f.vim'
Plug 'matze/vim-move'
Plug 'majutsushi/tagbar'
Plug 'christoomey/vim-tmux-navigator'

" Searching/Fuzzyfind
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-key-bindings --no-completion --update-rc' }
Plug 'junegunn/fzf.vim'

" Color schemes
Plug 'nanotech/jellybeans.vim'
Plug 'ap/vim-css-color'

" Code completion
Plug 'Shougo/deoplete.nvim',		{ 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go',			{ 'do': 'make'}
Plug 'jiangmiao/auto-pairs'

" Filetype plugin
Plug 'wilriker/vim-fish',			{ 'for':  'fish' }
Plug 'tfnico/vim-gradle',			{ 'for':  'groovy' }
Plug 'wilriker/systemd-vim-syntax',	{ 'for': 'systemd' }
Plug 'wilriker/udev-vim-syntax',	{ 'for': 'udev' }
Plug 'kchmck/vim-coffee-script',	{ 'for': 'coffee' }
Plug 'chrisbra/csv.vim'
Plug 'tmux-plugins/vim-tmux',		{ 'for': 'tmux' }
Plug 'fatih/vim-go',				{ 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'firef0x/pkgbuild.vim',		{ 'for': 'PKGBUILD' }
Plug 'smancill/conky-syntax.vim',	{ 'for': 'conkyrc' }
Plug 'wilriker/gnuplot.vim',		{ 'for': 'gnuplot' }
Plug 'fidian/hexmode'

" All of your Plugins must be added before the following line
call plug#end()						" Add plugins to &runtimepath

" Working directories
set dir=~/tmp,/tmp,/var/tmp,.

set hidden							" Enable automatic hiding of buffers even when they are modified

set laststatus=2					" Always display statusline
set updatetime=250					" Update gitgutter after this many ms (also write swapfile)

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
set scrolloff=5						" Number of lines to keep above/below cursor as context
set sidescrolloff=5					" Number of columns to keep left/right of cursor as context

set cursorline						" highlight current line

set splitright						" a new window is put right of the current one

set showcmd							" show the command being typed
set noerrorbells					" don't ring the bell for error messages
set title							" show info in the window title
set noshowmode						" don't show the current mode in status line (airline already has it)
set wildmode=longest:full			" Only complete until the longest common match and then show wildmenu

set undofile						" Save undo information to a file
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

" Code completion
let g:deoplete#enable_at_startup = 1
set completeopt=menu,preview,noinsert

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/linux_amd64'

" Silver Searcher ag.vim
let g:ag_working_path_mode="r"		" start search in project root

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1
let g:go_def_reuse_buffer = 1
let g:go_fmt_command = "goimports"

" move
let g:move_key_modifier = 'C'

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
	autocmd WinEnter,VimEnter * highlight ExtraWhitespace ctermbg=red guibg=#ff0000
	autocmd WinEnter,VimEnter * call matchadd('ExtraWhitespace', '\s\+$', -1)
augroup END

" Custom key mappings
let mapleader = ","

" BufOnly
nmap <silent> <Leader>bo :BufOnly<CR>

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <S-Up>    :TmuxNavigateUp<CR>
nnoremap <S-Down>  :TmuxNavigateDown<CR>
nnoremap <S-Left>  :TmuxNavigateLeft<CR>
nnoremap <S-Right> :TmuxNavigateRight<CR>
nnoremap <C-W>k    :TmuxNavigateUp<CR>
nnoremap <C-W>j    :TmuxNavigateDown<CR>
nnoremap <C-W>h    :TmuxNavigateLeft<CR>
nnoremap <C-W>l    :TmuxNavigateRight<CR>

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

" Tabularize
nmap <silent> <Leader>t= ggVG:Tabularize /=<CR>
nmap <silent> <Leader>t: ggVG:Tabularize /:<CR>
nmap <silent> <Leader>t, ggVG:Tabularize /,<CR>
nmap <silent> <Leader>t; ggVG:Tabularize /;<CR>
nmap <silent> <Leader>t" ggVG:Tabularize /"<CR>
nmap <silent> <Leader>tt ggVG:Tabularize /\t<CR>
vmap <silent> <Leader>t= :Tabularize /=<CR>
vmap <silent> <Leader>t: :Tabularize /:<CR>
vmap <silent> <Leader>t, :Tabularize /,<CR>
vmap <silent> <Leader>t; :Tabularize /;<CR>
vmap <silent> <Leader>t" :Tabularize /"<CR>
vmap <silent> <Leader>tt :Tabularize /\t<CR>

" vim-fish
nmap <silent> <Leader>fi gggqG<CR>

" tagbar
nmap <silent> <Leader>o :TagbarToggle<CR>

" vim-go
augroup VimGo
	autocmd!
	autocmd FileType go nmap <silent> <Leader>gr <Plug>(go-run)
	autocmd FileType go nmap <silent> <Leader>gb <Plug>(go-build)
	autocmd FileType go nmap <silent> <Leader>gi <Plug>(go-install)
	autocmd FileType go nmap <silent> <Leader>go <Plug>(go-imports)
	autocmd FileType go nmap <silent> <Leader>gd <Plug>(go-doc-browser)
	autocmd FileType go nmap <silent> <Leader>gv <Plug>(go-def-vertical)
	autocmd FileType go nmap <silent> <Leader>gn <Plug>(go-rename)
	autocmd FileType go nmap <silent> <Leader>gh <Plug>(go-callers)
augroup END

" Remove trailing whitespace
nmap <silent> <Leader>w :silent! %s/\s\+$//<CR>
nmap <silent> <Leader>c :nohlsearch<CR>

" Show/hide whitespace (except space)
nmap <silent> <F12> :set list!<CR>
imap <silent> <F12> <C-o>:set list!<CR>

" Key mappings to edit/reload config files
nmap <silent> <Leader>s :w <Bar> source ~/.config/nvim/init.vim<CR>
nmap <silent> <Leader>v :e ~/.config/nvim/init.vim<CR>
nmap <silent> <Leader>f :e ~/.config/fish/config.fish<CR>

" Copy/Paste
vnoremap <silent> <Leader>y "+y<CR>
nnoremap <silent> <Leader>p "+gp<CR>
nnoremap <silent> <Leader>P "+gP<CR>

" silver searcher (through fzf)
nnoremap <Leader>ag :Ag<Space>
nnoremap <Leader>ac :Ag <C-r><C-w><CR>

" Save as root if forgotten to start with sudo
cmap w!! w !sudo tee % > /dev/null

