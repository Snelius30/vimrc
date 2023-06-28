" cursor changes for the modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[1 q"
set t_u7=

set noswapfile
set nobackup
set nowritebackup
"set guifont=Menlo:h13
"set guifont=Courier:h14
"set guifont=Cascadia\ Mono:h16
set guifont=JetBrains\ Mono:h19
set guioptions-=r
set cc=120
set mouse=a
set ttymouse=sgr
set timeoutlen=1000
set ttimeoutlen=50
set hlsearch
set incsearch
" set clipboard=unnamed " Sync clipboadrs with a OS
set autoindent
filetype plugin indent on
set title
set updatetime=300
set autoread
set relativenumber
" set cindent
" set smartindent
set tabstop=8
set softtabstop=4
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set noequalalways " don't resize window after close one
set cursorline " highlight cursor line
" some speed up. 2 lines below
set lazyredraw
"set regexpengine=1
"set redrawtime=10000
" fix some terms colors
set t_Co=256

set undodir=~/.vim/undodir
set undofile

set sessionoptions-=blank
" folding
set foldmethod=manual
set foldcolumn=1 "defines 1 col at window left, to indicate folding
set foldlevelstart=99 "start file with all folds opened
set hidden " allow change buffers without saving
" fix clearing in wsl
set t_ut=
" gitgutter
set signcolumn=yes

" Plugins Actions
"
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" ALE Config
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'thaerkh/vim-workspace'
Plug 'junegunn/vim-easy-align'
Plug 'dyng/ctrlsf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
Plug 'chr4/nginx.vim'
Plug 'joshdick/onedark.vim' " theme
Plug 'sainnhe/gruvbox-material' " theme
Plug 'NLKNguyen/papercolor-theme' " theme
Plug 'arcticicestudio/nord-vim' "theme
Plug 'sainnhe/everforest' " theme
"Plug 'shapeoflambda/dark-purple.vim' " theme
Plug 'AlessandroYorba/Alduin' " theme
Plug 'jaredgorski/Mies.vim' " theme
Plug 'kristijanhusak/vim-hybrid-material' " theme
Plug 'lepture/vim-jinja'
Plug 'stephpy/vim-yaml'
call plug#end()

" Tree style for netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" Plugin settings
"
" Markdown
let g:markdown_fenced_languages = ['typescript', 'javascript', 'js=javascript', 'json', 'yaml', 'perl']

let g:ctrlsf_auto_preview = 1
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_search_mode = 'async'

" Multi cursor
let g:VM_mouse_mappings = 1

let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_background = 'medium'
" For better performance
"let g:gruvbox_material_better_performance = 1

"vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mapping_enabled = 0

let g:workspace_session_directory       = $HOME . '/.vim/sessions/'
let g:workspace_undodir                 = $HOME . '/.vim/undodir/'
let g:workspace_autosave_always         = 0
let g:workspace_autosave                = 0
let g:workspace_session_disable_on_args = 1

"NERDTree
let g:NERDTreeWinSize=55
let g:NERDTreeDirArrows=0
let g:NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', 'node_modules'] ", '\.js$[[file]]', '\.map$[[file]]'] ignore files in NERDTree
let g:NERDTreeMouseMode=2
" // NERDTree

"let g:airline_theme='gruvbox_material'
let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#coc#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks =
    \  [ 'indent', 'trailing', 'long', 'conflicts'  ]

" Colors
if system('echo -n $SSH_CONNECTION') == ''
    set termguicolors
endif

" let g:alduin_Shout_Become_Ethereal = 1
" let g:alduin_Shout_Aura_Whisper = 1
set background=dark
colorscheme gruvbox-material

if has('win32')
    if system("powershell.exe Get-ItemProperty -Path
                \ \" HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\"
                \ -Name AppsUseLightTheme | grep AppsUse | awk '{ print $3 }'") == 0
        set background=dark
        colorscheme gruvbox-material
    else
        set background=light
        colorscheme PaperColor
    endif
endif

let g:enable_bold_font = 0

if has("autocmd")
  " Remember last position.
  au BufReadPost * if line("'\"") > -1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  " Set filetype for JSON5
  au BufNewFile,BufRead *.json5 setfiletype json5
  au FileType go setlocal noet ci pi sts=0 sw=4 ts=4 list
  au FileType markdown setlocal spell spelllang=ru_yo,en_us
  au FileType text setlocal spell spelllang=ru_yo,en_us
endif


" Keybindings
"
map <C-T> :FZF<CR>
map <F6> :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>
" recovery last closed split window
nmap <C-x><C-l> :vs<bar>:b#<CR>
nmap <C-a><C-i> :normal vi}ga:<CR>
" tt to toggle tree
map tt :NERDTreeToggle<CR><C-w>w
" ff to find/reveal current file in tree
map ff :NERDTreeFind<CR>
" nmap <C-x><C-t> :TagbarToggle<CR>
nmap <C-x><C-t> :Tags<CR>
" vim-easy-align sds
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" Do not jump by search pressed #
nnoremap * :keepjumps normal! mi*`i<CR>
nnoremap Y y$
nnoremap <C-h> :vertical resize +5<CR>
nnoremap <C-l> :vertical resize -5<CR>
nnoremap <C-k> :move -2<CR>
nnoremap <C-j> :move +1<CR>
" nnoremap <C-S> :ToggleWorkspace<CR>
nnoremap <C-P> :Buffers<CR>
nnoremap <C-x><C-B> :BTags<CR>
nnoremap <C-x><C-R> :Tags<CR>
nnoremap <C-x><C-f> :CtrlSF -G *.ts<Space>
nnoremap <C-x><C-p> :%!jq .<CR>
nnoremap <C-x>y :normal viw"*y<CR>
nmap <silent><C-x><C-g> :call setbufvar(winbufnr(popup_atcursor(split(system("git log -n 1 -L " . line(".") . ",+1:"
    \ .  expand("%:p")), "\n"), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0  })), "&filetype", "git")<CR>

set directory^=$HOME/.vim/tmp//

set showbreak=↪\
set listchars=tab:→\ ,eol:¬,nbsp:␣,trail:•,extends:⟩,precedes:⟨

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
