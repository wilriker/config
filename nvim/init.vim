" Make sure vim-plug is installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" initialize vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Status extensions
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Functional extentions
Plug 'tpope/vim-commentary'
Plug 'valloric/listtoggle'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'matze/vim-move'
Plug 'embear/vim-localvimrc'
" Plug 'liuchengxu/vim-which-key',	{ 'on': ['WhichKey', 'WhichKey!'] }

" Color schemes
Plug 'joshdick/onedark.vim'
Plug 'ap/vim-css-color'
Plug 'wilriker/vim-trailing-whitespace'
Plug 'junegunn/rainbow_parentheses.vim'

" Code formatting
Plug 'godlygeek/tabular',			{ 'on': 'Tabularize' }

" VCS related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'sjl/splice.vim'

" Navigation
Plug 'scrooloose/nerdtree',			{ 'on': 'NERDTreeFind' }
Plug 'schickling/vim-bufonly',		{ 'on': 'BufOnly' }
Plug 'majutsushi/tagbar',			{ 'on': 'TagbarToggle' }
Plug 'wilriker/vim-tmux-navigator'

" Searching/Fuzzyfind
Plug 'junegunn/fzf',				{ 'dir': '~/.fzf', 'do': './install --no-key-bindings --no-completion' }
Plug 'junegunn/fzf.vim'

" Code completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'autozimu/languageclient-neovim', {'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/deoplete.nvim',		{ 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
" Plug 'zchee/deoplete-go',			{ 'do': 'make'}
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-endwise'
" Plug 'beeender/Comrade'

" Filetype plugin
Plug 'wilriker/vim-fish',			{ 'for': 'fish' }
Plug 'tfnico/vim-gradle',			{ 'for': 'groovy' }
Plug 'Matt-Deacalion/vim-systemd-syntax',	{ 'for': 'systemd' }
Plug 'wilriker/udev-vim-syntax',	{ 'for': 'udev' }
Plug 'kchmck/vim-coffee-script',	{ 'for': 'coffee' }
Plug 'ericpruitt/tmux.vim',			{ 'for': 'tmux', 'rtp': 'vim' }
Plug 'fatih/vim-go',				{ 'for': 'go' }
Plug 'firef0x/pkgbuild.vim',		{ 'for': 'PKGBUILD' }
Plug 'smancill/conky-syntax.vim',	{ 'for': 'conkyrc' }
Plug 'wilriker/gnuplot.vim',		{ 'for': 'gnuplot' }
Plug 'uarun/vim-protobuf',			{ 'for': 'proto' }
Plug 'rid9/vim-fstab',				{ 'for': 'fstab' }
Plug 'lervag/vimtex',				{ 'for': 'tex' }
Plug 'chr4/nginx.vim',				{ 'for': 'nginx' }
Plug 'toml-lang/toml',				{ 'for': 'toml' }
Plug 'sirtaj/vim-openscad',			{ 'for': 'openscad' }
Plug 'pangloss/vim-javascript',		{ 'for': 'javascript' }
Plug 'posva/vim-vue'
Plug 'chrisbra/csv.vim'
Plug 'fidian/hexmode'
Plug 'vim-scripts/txt.vim'
Plug 'wilriker/gcode.vim'

" All of your Plugins must be added before the following line
call plug#end()						" Add plugins to &runtimepath

" Buffers
set hidden							" Enable automatic hiding of buffers even when they are modified
set splitright						" a new window is put right of the current one

" Statusline and title
set cmdheight=2						" Better display for messages
set showcmd							" show the command being typed
set noerrorbells					" don't ring the bell for error messages
set title							" show info in the window title
set noshowmode						" don't show the current mode in status line (airline already has it)
set shortmess+=c					" don't give |ins-completion-menu| messages.

set updatetime=100					" Update gitgutter after this many ms (also write swapfile)

" Line numbers
set number							" turn on line numbers
set numberwidth=5					" We are good up to 9999 lines
set signcolumn=yes					" always show signcolumns

" always switch to the current file directory
augroup CWD
	autocmd!
	autocmd BufEnter * silent! lcd %:p:h
augroup END

" Search and Replace
set wrapscan						" searches wrap around the end of the buffer
set ignorecase						" case insensitive searches
set smartcase						" if there are caps, go case-sensitive
set inccommand=split				" interactive search-and-replace

" Line display
set nowrap							" do not wrap lines
set linebreak						" but do break at word boundaries if wrapping is enabled
set breakindent						" and also indent broken lines
set scrolloff=5						" Number of lines to keep above/below cursor as context
set sidescrolloff=5					" Number of columns to keep left/right of cursor as context

" Undo
set undofile						" Save undo information to a file

" change the appearance of whitespace when :set list is on
set listchars=tab:>\ ,eol:$,nbsp:%,space:.,precedes:<,extends:>
set showbreak=↳\ 					" Show marker for wrapped lines

" Brace/Bracket/Parentheses matching
set showmatch						" show matching brackets
set matchpairs+=<:>					" define the matching brackets
" Set a pair for assignments in Java and C/C++
augroup MatchPairs
	autocmd!
	autocmd FileType c,cpp,java set matchpairs+==:;
augroup END

" tabs and indenting
set tabstop=4						" make tabs 4 characters wide
set shiftwidth=4					" make whitespace indentation 4 characters wide
set nosmarttab						" don't insert spaces for <TAB> in indentations
set softtabstop=4					" make expanded tabs 4 characters wide
set noexpandtab						" do not expand tabs to single whitespaces

" Colorscheme and other UI settings
set mouse=a
set termguicolors					" Enable 24 bit colors
"set cursorline						" highlight current line - can make scrolling painfully slow
augroup Onedark
	autocmd!
	autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": {"gui": "#ABB2BF", "cterm": "145", "cterm16": "7"} })
augroup END
let g:onedark_terminal_italics = 1
colorscheme onedark
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" vim-rooter
" let g:rooter_manual_only = 1
let g:rooter_patterns = ['go.mod', '.git', '.git/']
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_cd_cmd = "lcd"

" localvimrc
let g:localvimrc_whitelist='/home/mcoenen/workspace/.*'

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" Code completion
let g:deoplete#enable_at_startup = 1
set completeopt=menu,preview,noinsert

let g:LanguageClient_rootMarkers = {
        \ 'go': ['.git', 'go.mod'],
        \ }

let g:LanguageClient_serverCommands = {
	\ 'css':        ['css-languageserver', '--stdio'],
	\ 'go':         ['gopls'],
	\ 'html':       ['html-languageserver', '--stdio'],
	\ 'rust':		['rustup', 'run', 'stable', 'rls'],
	\ 'javascript': ['/usr/bin/javascript-typescript-stdio'],
	\ 'typescript': ['/usr/bin/javascript-typescript-stdio'],
	\ 'vue':		['/usr/bin/vls'],
	\ 'python':     ['/usr/bin/pyls'],
	\ }

let g:LanguageClient_rootMarkers = {
	\ 'go': ['go.mod'],
	\ }

let g:LanguageClient_loggingFile = expand('/tmp/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('/tmp/LanguageClient.log')

" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

" let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
" let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" vim-go
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" let g:go_auto_type_info = 1
let g:go_def_reuse_buffer = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
" let g:go_metalinter_autosave = 1
let g:go_auto_sameids = 1
" let g:go_autodetect_gopath = 1
let g:go_addtags_transform = "camelcase"

" move
let g:move_key_modifier = 'C'

" vim-tmux-navigator
let g:tmux_navigator_diplay_panes = 1

" rainbow_parentheses
let g:rainbow#pairs = [['{', '}'], ['(', ')'], ['[', ']']]

" Functions
let g:true = 1
let g:false = 0

" Buffer Count
function! s:BufferCount(ignoreQuickfix)
	let l:filter = 'buflisted(v:val)' . (a:ignoreQuickfix ? ' && getbufvar(v:val, "&buftype") !=# "quickfix"' : '')
	return len(filter(range(1, bufnr('$')), l:filter))
endfunction

" Close buffer and skip quickfix/location
function! s:CloseBuffer()
	let l:buffernr = bufnr('%')

	" If the current buffer is the last one create a new one to switch to
	" and that disappears once we load a new file into it
	if s:BufferCount(g:true) == 1
		enew | setlocal noswapfile bufhidden=wipe buftype=
	else
		bprevious
		while &buftype ==# 'quickfix' | bprevious | endwhile
	endif
	execute 'bdelete! '.l:buffernr
endfunction

" Create mappings to switch buffers/quickfix/location/tabs
function! s:MapNextFamily(map,cmd)
	let cmd = '".(v:count ? v:count : "")."'.a:cmd
	let end = '"<CR>'.(a:cmd == 'l' || a:cmd == 'c' ? 'zv' : '')
	execute 'nnoremap <silent> ['.a:map.'          :<C-U>exe "'.cmd.'previous'.end
	execute 'nnoremap <silent> ]'.a:map.'          :<C-U>exe "'.cmd.'next'.end
	execute 'nnoremap <silent> ['.toupper(a:map).' :<C-U>exe "'.cmd.'first'.end
	execute 'nnoremap <silent> ]'.toupper(a:map).' :<C-U>exe "'.cmd.'last'.end
	if exists(':'.a:cmd.'nfile')
		execute 'nnoremap <silent> [<C-'.a:map.'> :<C-U>exe "'.cmd.'pfile'.end
		execute 'nnoremap <silent> ]<C-'.a:map.'> :<C-U>exe "'.cmd.'nfile'.end
	endif
endfunction

" Wrapper function to execute Ag with cwd of project root (if detected).
" This requires https://github.com/dylanaraps/root.vim
function! s:AgInVCSRoot(...)
	" save current working dir
	let l:cwd = getcwd()
	" Set to root of project
	call FindRootDirectory()
	" Call ag
	call call('fzf#vim#ag', a:000)
	" Restore current working dir
	execute "lcd ".l:cwd
endfunction

command! -bang -nargs=* Ag call s:AgInVCSRoot(<q-args>, <bang>0)

" match lines containing todos regardless if filetype highlights differently
augroup HighlightTodos
	autocmd!
	highlight default ToDoLine ctermbg=red guibg=#362C2C guifg=#FF2424
	autocmd ColorScheme * highlight default ToDoLine ctermbg=red guibg=#362C2C guifg=#FF2424
	autocmd BufRead,BufNew * call matchadd('ToDoLine', '\v(TODO|FIXME|XXX).*$')
augroup END

" rainbow_parentheses
augroup RainbowParentheses
	autocmd!
	autocmd VimEnter * RainbowParentheses
augroup END

" Window positions and skipping
augroup WindowProperties
	autocmd!
	" Always place quickfix/location at the bottom with full width
	autocmd FileType qf wincmd J
	" Unlist preview window so it will be skipped when switching buffers
	autocmd WinEnter * if &previewwindow | setlocal nobuflisted | endif
augroup END

" txt.vim
augroup TxtVim
	autocmd!
	autocmd BufWinEnter,BufNewFile * if &filetype == '' | setfiletype txt | endif
augroup END

" Python
" augroup Python-buffer
" 	autocmd! * <buffer>
" 	autocmd BufWritePre <buffer> undojoin | call LanguageClient#textDocument_formatting()
" augroup END

command! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
command! FormatJSON :%!python -m "json.tool"

" Custom key mappings
let mapleader = ","
let maplocalleader = "-"

" Create prevnext mappings
call s:MapNextFamily('b','b')
call s:MapNextFamily('l','l')
call s:MapNextFamily('q','c')
call s:MapNextFamily('t','tab')

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
nnoremap <silent> <Leader>ss :split<CR>
nnoremap <silent> <Leader>sv :vsplit<CR>

" Buffer management
nnoremap <silent> <Leader>T :enew<CR>
nnoremap <silent> <Leader>bq :call <SID>CloseBuffer()<CR>
nnoremap <silent> <Leader>be :bufdo checktime <Bar> bufdo GitGutterAll<CR>

" BufOnly
nnoremap <silent> <Leader>bo :BufOnly<CR>

" FuzzyFind
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fg :GFiles<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fl :Lines<CR>
nnoremap <silent> <Leader>fc :Commits<CR>
nnoremap <silent> <Leader>fs :Snippets<CR>
" The following mappings do not work when using *noremap as <Plug>-prefixed
" commands ARE mappings - noremap would ignore them
nmap <Leader><Tab> <Plug>(fzf-maps-n)
xmap <Leader><Tab> <Plug>(fzf-maps-x)
omap <Leader><Tab> <Plug>(fzf-maps-o)

" Tabularize
nnoremap <silent> <Leader>t= ggVG:Tabularize /=<CR>
nnoremap <silent> <Leader>t: ggVG:Tabularize /:<CR>
nnoremap <silent> <Leader>t, ggVG:Tabularize /,<CR>
nnoremap <silent> <Leader>t; ggVG:Tabularize /;<CR>
nnoremap <silent> <Leader>t" ggVG:Tabularize /"<CR>
nnoremap <silent> <Leader>tt ggVG:Tabularize /\t<CR>
nnoremap <silent> <Leader>t. ylggVG:Tabularize /<C-r>"<CR>
vnoremap <silent> <Leader>t= :Tabularize /=<CR>
vnoremap <silent> <Leader>t: :Tabularize /:<CR>
vnoremap <silent> <Leader>t, :Tabularize /,<CR>
vnoremap <silent> <Leader>t; :Tabularize /;<CR>
vnoremap <silent> <Leader>t" :Tabularize /"<CR>
vnoremap <silent> <Leader>tt :Tabularize /\t<CR>

" vim-fish
augroup VimFish
	autocmd!
	autocmd FileType fish nnoremap <buffer> <silent> <LocalLeader>i :FishIndent<CR>
augroup END

" listtoggle
let g:lt_location_list_toggle_map = '<Leader>ql'
let g:lt_quickfix_list_toggle_map = '<Leader>qq'
nnoremap <silent> <Leader>qp :pclose<CR>

" tagbar
nnoremap <silent> <F2> :TagbarToggle<CR>

" NERDTree
nnoremap <silent> <expr> <F3> exists("g:NERDTree") && g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : ':NERDTreeFind<CR>'

" obsession
nnoremap <silent> <Leader>os :Obsess<CR>
nnoremap <silent> <Leader>od :Obsess!<CR>
nnoremap <silent> <Leader>ol :source Session.vim<CR>

" LanguageClient
func LC_maps()
	if has_key(g:LanguageClient_serverCommands, &filetype)
		nnoremap <buffer> <silent>         K  :call LanguageClient#textDocument_hover()<cr>
		nnoremap <buffer> <silent>         gd :call LanguageClient#textDocument_definition()<CR>
		nnoremap <buffer> <silent> <Leader>lm :call LanguageClient_contextMenu()<CR>
		nnoremap <buffer> <silent> <Leader>lr :call LanguageClient#textDocument_rename()<CR>
		nnoremap <buffer> <silent> <Leader>lcrs :call LanguageClient#textDocument_rename({'newName': Abolish.snakecase(expand('<cword>'))})<CR>
		nnoremap <buffer> <silent> <Leader>lcru :call LanguageClient#textDocument_rename({'newName': Abolish.uppercase(expand('<cword>'))})<CR>
		nnoremap <buffer> <silent> <Leader>lcrm :call LanguageClient#textDocument_rename({'newName': Abolish.mixedcase(expand('<cword>'))})<CR>
		nnoremap <buffer> <silent> <Leader>lcrc :call LanguageClient#textDocument_rename({'newName': Abolish.camelcase(expand('<cword>'))})<CR>
		nnoremap <buffer> <silent> <Leader>lcr- :call LanguageClient#textDocument_rename({'newName': Abolish.dashcase(expand('<cword>'))})<CR>
		nnoremap <buffer> <silent> <Leader>lcr. :call LanguageClient#textDocument_rename({'newName': Abolish.dotcase(expand('<cword>'))})<CR>
		nnoremap <buffer> <silent> <Leader>lcrt :call LanguageClient#textDocument_rename({'newName': Abolish.titlecase(expand('<cword>'))})<CR>
		nnoremap <buffer> <silent> <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
		nnoremap <buffer> <silent> <Leader>lh :call LanguageClient#textDocument_references()<CR>
		nnoremap <buffer> <silent> <Leader>li :call LanguageClient#textDocument_implementation()<CR>
		nnoremap <buffer> <silent> <Leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
	endif
endfunction
autocmd FileType * call LC_maps()

" vim-go
augroup VimGo
	autocmd!
" 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>R <Plug>(go-run)
" 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>I <Plug>(go-install)
	autocmd FileType go nmap <buffer> <silent> <LocalLeader>b <Plug>(go-build)
" 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>i <Plug>(go-imports)
" 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>s <Plug>(go-implements)
" 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>d <Plug>(go-doc-browser)
" 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>v <Plug>(go-def-vertical)
" 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>r <Plug>(go-rename)
" 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>h <Plug>(go-callers)
 	autocmd FileType go nmap <buffer> <silent> <LocalLeader>at :GoAddTags<CR>
augroup END

" Remove trailing whitespace
nnoremap <silent> <Leader>w :FixWhitespace<CR>
nnoremap <silent> <Leader><Space> :nohlsearch<CR>

" Pretty Format XML
nnoremap <Leader>= :FormatXML<Cr>

" Make search results appear in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Show/hide whitespace (except space)
nnoremap <silent> <F12> :set list!<CR>
inoremap <silent> <F12> <C-o>:set list!<CR>

" Output the highlight type of the element under the cursor
nnoremap <silent> <Leader>sh :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>

" Key mappings to edit/reload config files
nnoremap <silent> <Leader>vs :write <Bar> source $MYVIMRC<CR>
nnoremap <silent> <Leader>vv :edit $MYVIMRC<CR>
nnoremap <silent> <Leader>f :edit ~/.config/fish/config.fish<CR>

" Copy/Paste to/from system clipboard
nnoremap <silent> <Leader>Y :yank +<CR>
vnoremap <silent> <Leader>y "+y<CR>
nnoremap <silent> <Leader>p "+gp<CR>
nnoremap <silent> <Leader>P "+gP<CR>
nnoremap <silent> cv :put +<CR>

" silver searcher (through fzf)
nnoremap <Leader>ag :Ag<Space>
nnoremap <Leader>ac :Ag <C-r><C-w><CR>

" Save as root if forgotten to start with sudo
cnoremap w!! w !sudo tee % > /dev/null

" prevent ex mode
nnoremap Q <Nop>
nnoremap gQ <Nop>

" Manually activate code completion
inoremap <silent> <C-Space> <C-x><C-o>

