" Prevent issues with non-bourne-shells
"if $SHELL =~ 'bin/zsh'
"	set shell=/bin/bash
"endif
"if $SHELL =~ 'bin/fish'
	"set shell=/bin/bash
"endif

" Make sure vim-plug is installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" initialize vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Color schemes
Plug 'nanotech/jellybeans.vim'
Plug 'ap/vim-css-color'

" Code formatting
Plug 'tpope/vim-endwise'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/rainbow_parentheses.vim'

" Other stuff
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'edkolev/tmuxline.vim'
Plug 'schickling/vim-bufonly'
Plug 'valloric/listtoggle'
Plug 'tpope/vim-obsession'
Plug 'scrooloose/nerdtree'

" Navigation
Plug 'rhysd/clever-f.vim'
Plug 'matze/vim-move'
Plug 'majutsushi/tagbar'
Plug 'christoomey/vim-tmux-navigator'

" Searching/Fuzzyfind
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-key-bindings --no-completion --update-rc' }
Plug 'junegunn/fzf.vim'

" Code completion
Plug 'Shougo/deoplete.nvim',		{ 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go',			{ 'do': 'make'}
Plug 'jiangmiao/auto-pairs'

" Filetype plugin
Plug 'wilriker/vim-fish',			{ 'for': 'fish' }
Plug 'tfnico/vim-gradle',			{ 'for': 'groovy' }
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

" Buffers
set hidden							" Enable automatic hiding of buffers even when they are modified
set splitright						" a new window is put right of the current one

" Statusline and title
set showcmd							" show the command being typed
set noerrorbells					" don't ring the bell for error messages
set title							" show info in the window title
set noshowmode						" don't show the current mode in status line (airline already has it)
set wildmode=full					" Only complete until the longest common match and then show wildmenu

set updatetime=250					" Update gitgutter after this many ms (also write swapfile)

" Line numbers
set number							" turn on line numbers
set numberwidth=5					" We are good up to 9999 lines

" Search and Replace
autocmd BufEnter * silent! lcd %:p:h " always switch to the current file directory
set wrapscan						" searches wrap around the end of the buffer
set ignorecase						" case insensitive searches
set smartcase						" if there are caps, go case-sensitive
set inccommand=split				" interactive search-and-replace

" Line display
set nowrap							" do not wrap lines
set scrolloff=5						" Number of lines to keep above/below cursor as context
set sidescrolloff=5					" Number of columns to keep left/right of cursor as context

" Undo
set undofile						" Save undo information to a file
set undolevels=1000					" maximum number of changes that can be undone

set listchars=tab:▸\ ,eol:$,nbsp:%	" change the tab and eol characters

" Brace/Bracket/Parentheses matching
set showmatch						" show matching brackets
set matchpairs+=<:>					" define the matching brackets
au FileType c,cpp,java set mps+==:;	" Set a pair for assignments in Java and C/C++

" tabs and indenting
set tabstop=4						" make tabs 4 characters wide
set shiftwidth=4					" make whitespace indentation 4 characters wide
set nosmarttab						" don't insert spaces for <TAB> in indentations
set softtabstop=4					" make expanded tabs 4 characters wide
set noexpandtab						" do not expand tabs to single whitespaces

" Colorscheme and other UI settings
set termguicolors					" Enable 24 bit colors
"set cursorline						" highlight current line
colorscheme jellybeans
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1	" Enable pipe as cursor in INPUT mode - can be removed in nvim 0.2.0
if has('gui')
	set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 9
endif

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" Code completion
let g:deoplete#enable_at_startup = 1
set completeopt=menu,preview,noinsert

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/linux_amd64'

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
let g:go_metalinter_autosave = 1

" move
let g:move_key_modifier = 'C'

" match lines containing todos regardless if filetype highlights differently
augroup HighlightTodos
	autocmd!
	autocmd WinEnter,VimEnter * highlight ToDoLine ctermbg=red guibg=#362C2C guifg=#FF2424
	autocmd WinEnter,VimEnter * call matchadd('ToDoLine', '\v(TODO|FIXME|XXX).*$')
augroup END

" match extra whitespace at the end of lines
augroup HighlightExtraWhitespace
	autocmd!
	autocmd WinEnter,VimEnter * highlight ExtraWhitespace ctermbg=red guibg=#ff0000
	autocmd WinEnter,VimEnter * call matchadd('ExtraWhitespace', '\s\+$')
augroup END

" rainbow_parentheses
let g:rainbow#pairs = [['{', '}'], ['(', ')'], ['[', ']']]
augroup RainbowParentheses
	autocmd!
	autocmd FileType java,c,go,list,clojure RainbowParentheses
augroup END

" Custom key mappings
let mapleader = ","

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <S-Up>    :TmuxNavigateUp<CR>
nnoremap <silent> <S-Down>  :TmuxNavigateDown<CR>
nnoremap <silent> <S-Left>  :TmuxNavigateLeft<CR>
nnoremap <silent> <S-Right> :TmuxNavigateRight<CR>
nnoremap <silent> <C-W>k    :TmuxNavigateUp<CR>
nnoremap <silent> <C-W>j    :TmuxNavigateDown<CR>
nnoremap <silent> <C-W>h    :TmuxNavigateLeft<CR>
nnoremap <silent> <C-W>l    :TmuxNavigateRight<CR>

" Splits
nmap <silent> <Leader>ss :split<CR>
nmap <silent> <Leader>sv :vsplit<CR>

" Buffer management
nmap <silent> <Leader>T :enew<CR>
nmap <silent> <expr> <Leader>bq len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 ? ':bprevious <Bar> bdelete! #<CR>' : ':bdelete!<CR>'
nmap <silent> <Leader>be :checktime<CR>
nmap <silent> gb :bnext<CR>
nmap <silent> gB :bprevious<CR>

" BufOnly
nmap <silent> <Leader>bo :BufOnly<CR>

" FuzzyFind
nmap <silent> <Leader>ff :Files<CR>
nmap <silent> <Leader>fg :GFiles<CR>
nmap <silent> <Leader>fb :Buffers<CR>
nmap <silent> <Leader>fl :Lines<CR>
nmap <silent> <Leader>fc :Commits<CR>
nmap <Leader><Tab> <Plug>(fzf-maps-n)
xmap <Leader><Tab> <Plug>(fzf-maps-x)
omap <Leader><Tab> <Plug>(fzf-maps-o)

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
augroup VimFish
	autocmd!
	autocmd FileType fish nmap <silent> <Leader>i gggqG<CR>
augroup END

" listtoggle
let g:lt_location_list_toggle_map = '<leader>ql'
let g:lt_quickfix_list_toggle_map = '<leader>qq'

" tagbar
nmap <silent> <F2> :TagbarToggle<CR>

" NERDTree
nmap <silent> <expr> <F3> g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : ':NERDTreeFind<CR>'

" obsession
nmap <silent> <Leader>os :Obsess<CR>
nmap <silent> <Leader>ok :Obsess!<CR>
nmap <silent> <Leader>ol :source Session.vim<CR>

" vim-go
augroup VimGo
	autocmd!
	autocmd FileType go nmap <silent> <Leader>gR <Plug>(go-run)
	autocmd FileType go nmap <silent> <Leader>gI <Plug>(go-install)
	autocmd FileType go nmap <silent> <Leader>gb <Plug>(go-build)
	autocmd FileType go nmap <silent> <Leader>gi <Plug>(go-imports)
	autocmd FileType go nmap <silent> <Leader>gs <Plug>(go-implements)
	autocmd FileType go nmap <silent> <Leader>gd <Plug>(go-doc-browser)
	autocmd FileType go nmap <silent> <Leader>gv <Plug>(go-def-vertical)
	autocmd FileType go nmap <silent> <Leader>gr <Plug>(go-rename)
	autocmd FileType go nmap <silent> <Leader>gh <Plug>(go-callers)
augroup END

" Remove trailing whitespace
nmap <silent> <Leader>w :silent! %s/\s\+$//<CR>
nmap <silent> <Leader><Space> :nohlsearch<CR>

" Show/hide whitespace (except space)
nmap <silent> <F12> :set list!<CR>
imap <silent> <F12> <C-o>:set list!<CR>

" Key mappings to edit/reload config files
nmap <silent> <Leader>vs :w <Bar> source $MYVIMRC<CR>
nmap <silent> <Leader>vv :e $MYVIMRC<CR>
nmap <silent> <Leader>f :e ~/.config/fish/config.fish<CR>

" Copy/Paste to/from system clipboard
vnoremap <silent> <Leader>y "+y<CR>
nnoremap <silent> <Leader>p "+gp<CR>
nnoremap <silent> <Leader>P "+gP<CR>

" silver searcher (through fzf)
nnoremap <Leader>ag :Ag<Space>
nnoremap <Leader>ac :Ag <C-r><C-w><CR>

" Save as root if forgotten to start with sudo
cmap w!! w !sudo tee % > /dev/null

" prevent ex mode
nnoremap Q <Nop>
nnoremap gQ <Nop>

" Manually activate code completion
imap <silent> <C-Space> <C-x><C-o>

