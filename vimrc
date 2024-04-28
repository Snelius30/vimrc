vim9script

# ======================================== Settings ========================================
# cursor changes for the modes
&t_SI = "\e[6 q"
&t_EI = "\e[1 q"
set t_u7=
set noswapfile
set nobackup
set nowritebackup
#set guifont=Menlo:h13
#set guifont=Courier:h14
set guifont=IBM\ Plex\ Mono:h13
# set guifont=JetBrains\ Mono:h15
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set cc=120
set tw=120
set mouse=a
set ttymouse=sgr
set timeoutlen=1000
set ttimeoutlen=50
set hlsearch
set incsearch
# set clipboard=unnamed # Sync clipboadrs with a OS
set autoindent
set title
set updatetime=300
set autoread
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
# On pressing tab, insert 4 spaces
set expandtab
set noequalalways # don't resize window after close one
set cursorline # highlight cursor line
# some speed up. 2 lines below
set lazyredraw
# fix some terms colors
set t_Co=256
# Dont show @ symbol for long lines. Show lines!!
set display+=lastline
# Add new line character at the end of file
set eol
# To avoid whitespace comparison vimdiff
set diffopt+=iwhite
set undodir=~/.vim/undodir
set undofile
# folding
set foldmethod=manual
set foldcolumn=1 #defines 1 col at window left, to indicate folding
set foldlevelstart=99 #start file with all folds opened
set hidden # allow change buffers without saving
# fix clearing in wsl
set t_ut=
# gitgutter
set signcolumn=yes
set directory^=$HOME/.vim/tmp//
set showbreak=↪\
set listchars=tab:→\ ,eol:¬,nbsp:␣,trail:•,extends:⟩,precedes:⟨

# ======================================== Plugins Install ========================================
# Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

# ALE Config
g:ale_fix_on_save = 1
g:ale_completion_enabled = 1
g:ale_cpp_cc_options = '-std=c++20 -Wall'
#let g:ale_cpp_clangd_options = '-std=c++20'
set omnifunc=ale#completion#OmniFunc

plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'dyng/ctrlsf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-eunuch'
# Themes
Plug 'sainnhe/gruvbox-material'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sainnhe/everforest'
Plug 'joshdick/onedark.vim'
plug#end()

# ======================================== Plugins settings ========================================

# Tree style for netrw
g:netrw_liststyle = 3
g:netrw_browse_split = 2
g:netrw_altv = 1
g:netrw_alto = 1
g:netrw_altfile = 1
g:netrw_banner = 0
# let g:netrw_keepdir = 0
#let g:netrw_preview = 1
g:netrw_winsize = 25
#
# Markdown
g:markdown_fenced_languages = ['typescript', 'javascript', 'js=javascript', 'json', 'yaml', 'perl', 'bash']

g:ctrlsf_auto_preview = 1
g:ctrlsf_regex_pattern = 1
g:ctrlsf_search_mode = 'async'

g:gruvbox_material_disable_italic_comment = 1
g:gruvbox_material_background = 'medium'
# For better performance
#let g:gruvbox_material_better_performance = 1

# vim-go
g:ale_linters = { 'go': ['gopls'] }
g:go_def_mode = 'gopls'
g:go_info_mode = 'gopls'
g:go_def_mapping_enabled = 0

g:airline#extensions#tabline#enabled = 0
g:airline#extensions#branch#enabled = 1
g:airline#extensions#whitespace#mixed_indent_algo = 2
g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'conflicts'  ]

# Colors

#g:enable_bold_font = 0

set termguicolors
colorscheme gruvbox-material
set background=dark

# ======================================== Startup commands ========================================
if has("autocmd")
    # Remember last position.
    au BufReadPost * {
        if line("'\"") > -1 && line("'\"") <= line("$")
            exe "normal! g`\""
        endif
    }
    # Set filetype for JSON5
    au BufNewFile,BufRead *.json5 setfiletype json5
    au BufNewFile,BufRead *.jenkinsfile setfiletype groovy
    au FileType go setlocal noet ci pi sts=0 sw=4 ts=4 list
    au FileType markdown setlocal spell spelllang=ru_yo,en_us
    au FileType text setlocal spell spelllang=ru_yo,en_us
    au FileType yaml setlocal equalprg=yamlfmt\ - keywordprg=ansible-doc
    au FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
endif


# ======================================== Keybindings ========================================
map <C-T> :FZF --history=/Users/avy/.fzf_history<CR>
nmap <C-x><C-t> :Tags<CR>
map <F6> :let $VIM_DIR=expand('%:p:h')<CR>:terminal ++rows=20<CR>cd $VIM_DIR<CR>
map <F5> :terminal ++rows=20<CR>
# tt to toggle tree
map tt :Vex .<CR>
# ff to find/reveal current file in tree
map ff :Vex<CR>
# vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
# Do not jump by search pressed *
nnoremap * :keepjumps normal! mi*`i<CR>
nnoremap Y y$
nnoremap <C-s> :wa \| mks! \| qa<CR>
nnoremap <C-h> :vertical resize +5<CR>
nnoremap <C-l> :vertical resize -5<CR>
nnoremap <C-k> :move -2<CR>
nnoremap <C-j> :move +1<CR>
nnoremap <C-P> :Buffers<CR>
nnoremap <C-x><C-B> :BTags<CR>
nnoremap <C-x><C-R> :Tags<CR>
nnoremap <C-x><C-f> :CtrlSF<Space>
nnoremap <C-x><C-p> :%!jq .<CR>
nnoremap <D-1> 1gt
nnoremap <D-2> 2gt
nnoremap <D-3> 3gt
imap <c-d> <esc>ddi
imap <c-u> <esc>gUiwi

# Show git commit for word under cursor
nmap <silent><C-x><C-g> :call setbufvar(winbufnr(popup_atcursor(split(system("git log -n 1 -L " . line(".") . ",+1:"
            \.  expand("%:p")), "\n"), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0  })), "&filetype", "git")<CR>

# set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨,multispace:\ \ \ ┊

# ======================================== Functions ========================================
def WipeBuffersWithoutFiles()
    var bufs = filter(range(1, bufnr('$')), 'bufexists(v:val) && empty(getbufvar(v:val, "&buftype")) && !filereadable(bufname(v:val))')
    if !empty(bufs)
        execute 'bwipeout' join(bufs)
    endif
enddef
command BWnex WipeBuffersWithoutFiles()

def BatSync()
    if &l:bg == "dark"
        silent :!sed -ie 's/light/dark/' ~/.config/bat/config
        redraw!
    else
        silent :!sed -ie 's/dark/light/' ~/.config/bat/config
        redraw!
    endif
enddef
command BatSync BatSync()
