" cursor changes for the modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[1 q"
set t_u7=

set cc=120
"set number
set mouse=a
if !has('nvim')
    set ttymouse=sgr
endif
set timeoutlen=1000
set ttimeoutlen=50
set hlsearch
set autoindent
set title
set updatetime=300
set autoread
set relativenumber
" set cindent
set smartindent
" show existing tabs with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
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

" Y - yunk to end of line
map Y y$

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'thaerkh/vim-workspace'
Plug 'junegunn/vim-easy-align'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'matze/vim-move'
Plug 'dyng/ctrlsf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
Plug 'chr4/nginx.vim'
Plug 'joshdick/onedark.vim' " theme
Plug 'sainnhe/gruvbox-material' " theme
Plug 'NLKNguyen/papercolor-theme' " theme
Plug 'arcticicestudio/nord-vim' "theme
Plug 'sainnhe/everforest' " theme
Plug 'shapeoflambda/dark-purple.vim' " theme
call plug#end()

" Markdown
let g:markdown_fenced_languages = ['typescript', 'javascript', 'js=javascript', 'json']

let g:ctrlsf_auto_preview = 1
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_search_mode = 'async'

" Multi cursor
let g:VM_mouse_mappings = 1

let g:gruvbox_material_disable_italic_comment = 1

"vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mapping_enabled = 0

" fix clearing in wsl
set t_ut=

if system('echo -n $SSH_CONNECTION') == ''
    set termguicolors
else
    "map <ESC>[1;5C <C-Right>
    "map! <ESC>[1;5C <C-Right>
    "map <ESC>[1;5D <C-Left>
    "map! <ESC>[1;5D <C-Left>
endif

if system("powershell.exe Get-ItemProperty -Path
    \ \" HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\"
    \ -Name AppsUseLightTheme | grep AppsUse | awk '{ print $3 }'") == 0
   set background=dark
   "colorscheme everforest
   colorscheme dark_purple
else
   set background=light
   colorscheme PaperColor
endif

map <C-T> :FZF<CR>
" recovery last closed split window
nmap <C-x><C-l> :vs<bar>:b#<CR>
nmap <C-a><C-i> :normal vi}ga:<CR>
" splits
"nnoremap <space> <c-w>w
nnoremap <C-left> <c-w>10<
nnoremap <C-right> <c-w>10>

" buffers
nnoremap <C-x><C-w> :bn<CR>
nnoremap <C-x><C-q> :bp<CR>

let g:enable_bold_font = 0 " for hybrid-material

if has("autocmd")
  " Remember last position.
  au BufReadPost * if line("'\"") > -1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  " Set filetype for JSON5
  au BufNewFile,BufRead *.json5 setfiletype json5
  au FileType go setlocal noet ci pi sts=0 sw=4 ts=4 list
  au FileType markdown setlocal spell spelllang=ru_yo,en_us
  au FileType text setlocal spell spelllang=ru_yo,en_us
endif

" gitgutter
set signcolumn=yes

let g:workspace_session_directory       = $HOME . '/.vim/sessions/'
let g:workspace_undodir                 = $HOME . '/.vim/undodir/'
let g:workspace_autosave_always         = 0
let g:workspace_autosave                = 0
let g:workspace_session_disable_on_args = 1

" nmap <C-x><C-t> :TagbarToggle<CR>
nmap <C-x><C-t> :Tags<CR>

" move plugin
let g:move_key_modifier = 'C'

" vim-easy-align sds
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"NERDTree
let g:NERDTreeWinSize=55
let g:NERDTreeDirArrows=0
let g:NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', 'node_modules'] ", '\.js$[[file]]', '\.map$[[file]]'] ignore files in NERDTree
" tt to toggle tree
map tt :NERDTreeToggle<CR><Space>
" ff to find/reveal current file in tree
map ff :NERDTreeFind<CR><Space>
" // NERDTree

let g:coc_global_extensions = ['coc-pairs', 'coc-eslint', 'coc-tsserver', 'coc-rls', 'coc-json', 'coc-swagger']
command -nargs=0 Swagger :CocCommand swagger.render
"let g:airline_theme='gruvbox_material'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#coc#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks =
    \  [ 'indent', 'trailing', 'long', 'conflicts'  ]

" Do not jump by search pressed #
nnoremap * :keepjumps normal! mi*`i<CR>

"nmap <silent> <C-d> :normal yyp<CR>
"nmap <silent> <C-y> :normal dd<CR>
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> <C-x><C-e> <Plug>(coc-references)
nnoremap <C-x><C-d> :CocFzfList diagnostics<CR>
nmap <leader>rn <Plug>(coc-rename)

nmap <silent> <C-x>? :call CocAction('diagnosticInfo')<cr>

nmap <silent> [c :call CocAction('diagnosticNext')<cr>
nmap <silent> ]c :call CocAction('diagnosticPrevious')<cr>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <C-S> :ToggleWorkspace<CR>
nnoremap <C-P> :Buffers<CR>
nnoremap <C-R> :BTags<CR>
nnoremap <C-x><C-R> :Tags<CR>
nnoremap <C-x><C-f> :CtrlSF -G *.ts<Space>
nnoremap <C-x><C-p> :%!jq .<CR>
nmap <silent><C-x><C-g> :call setbufvar(winbufnr(popup_atcursor(split(system("git log -n 1 -L " . line(".") . ",+1:" . expand("%:p")), "\n"), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0  })), "&filetype", "git")<CR>

" :Bwipeout[!]
" wipe all deleted/unloaded buffers
command! -bar -bang Bwipeout call misc#bwipeout(<bang>0)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

set directory^=$HOME/.vim/tmp//

let g:javascript_plugin_jsdoc = 1

set showbreak=↪\
set listchars=tab:→\ ,eol:¬,nbsp:␣,trail:•,extends:⟩,precedes:⟨
