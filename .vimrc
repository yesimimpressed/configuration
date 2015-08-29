"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: yangdong
"
" Version: 3.0 - 2015/6/9 15:02
" Version: 2.0 - 2015/2/4 19:57
" for Mac OS X
"
" Content
"	=> Default mac mvim config
"	=> TOP CONFIG
"	=> File operation
"		1. General
"		2. Encoding
"	=> Interface
"		1. colorscheme
"		2. font
"		3. format
"		4. work place
"		5. search
"	=> General Abbrevs
"	=> Plugins
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Default mac mvim config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TOP CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set history=200
	" Sets how many lines of history VIM has to remember

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" Default mapleader is "\"
let mapleader = ","
let g:mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File operation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""
" 1. General
"""""""""""""""""""
filetype plugin indent on
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
set autoread
	" Set to auto read when a file is changed from the outside

" Fast saving
nmap <leader>w :w!<cr>
"nmap <leader>c :bd!<cr>

" Turn backup off
set nobackup
set nowb
set noswapfile
set hid				" Change buffer - without saving
"""""""""""""""""""
" 2. Encoding
"""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin1
	" ucs-bom	: default
	" chinese	: cp936 in windows(GBK page), GB2312 in Unix
	" latin1	: ASCII
set langmenu=zh_CN.utf-8
language messages zh_cn.utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
	winpos 100 0
		"unit pixel
	set lines=40 columns=120
		"unit char
	"au GUIENTER * simalt ~x
		"打开窗口后最大化，仅限windows下使用
		"simalt:模拟alt键，~x:最大化。。。
endif
"""""""""""""""""""
" 1. colorscheme
"""""""""""""""""""
set background=dark
colorscheme desert
	"darkblue
	"blue
syntax enable
if has("gui_running")
	set guioptions-=T	" 'T'	Include Toolbar.
	set t_Co=256		" number of colors
endif
"""""""""""""""""""
" 2. font
"""""""""""""""""""
set guifont=Monaco:h18
	" default	Fixdsys
"set guifontwide=kaiti_GB2312:h14
	" set wide font; not good in win7
"set guifontwide=YaHei\ Mono:h13
	" need YaHei Mono
"set guifontwide=YaHei\ Consolas\ Hybrid:h14
	" need non-monospace font support
""""""""""""""""""
" 3. format
"""""""""""""""""""
set autoindent		"ai		设置自动缩进，添加新行时会有上一行的缩进
set tabstop=4		"ts		设置tab键缩进长度
set softtabstop=4	"sts
set expandtab		"tabs are spaces
set shiftwidth=4	"sw
set nolinebreak		"lbr	自动分行
set textwidth=200	"tw		行宽度
set wrap " when on, lines longer than the width of the window will wrap and displaying continues on the next line. like this.

"""""""""""""""""""
" 4. work place
"""""""""""""""""""
set number			"nu 显示行号
set scrolloff=4		"so 光标以上/以下保留行数
set wildmenu		"wmnu 命令行补全增强模式
set ruler			" 右下角显示当前光标行列信息
set showcmd			" 右下角显示操作命令
set cmdheight=2		" 命令栏高度

"""""""""""""""""""
" 5. search
"""""""""""""""""""
set ignorecase		" Ignore case when searching
set hlsearch		" Highlight search things
set incsearch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("20%y-%m-%d %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins/use vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" fantastic view
Plugin 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'

" file|buffer manager
"Plugin 'kien/ctrlp.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'majutsushi/tagbar'
Plugin 'jeetsukumaran/vim-buffergator'
"Plugin 'rking/ag.vim'
"Plugin 'fholgado/minibufexpl.vim'
"Plugin 'wincent/command-t'

" Git plugin
Bundle 'tpope/vim-fugitive'

" Python mode
Plugin 'Valloric/YouCompleteMe'
Bundle 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
"Plugin 'nvie/vim-flake8'


filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree Config
let NERDTreeIgnore = ['\.pyc$']
"let g:nerdtree_tabs_open_on_console_startup=1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc_autocmds
	autocmd!
	" highlight characters past column 120
	autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
	autocmd FileType python match Excess /\%120v.*/
	autocmd FileType python set nowrap
    augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" test field
set cursorline
set lazyredraw

set foldenable
set foldmethod=indent 
set foldlevelstart=10
set foldnestmax=10
" space open/closes folds
nnoremap <space> za

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>


" ==== buffer | window | tab ====
set hidden
nmap <c-\>m :only<cr>

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<cr>

" ==== buffergator settings ====
let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = 'B'

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

nmap <leader>bl :BuffergatorOpen<cr>
nmap <leader>jj :BuffergatorMruCyclePrev<cr>
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" CtrlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'wra'
"let g:ctrlp_root_markers = '~/working/dev'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/* 
let g:ctrlp_custom_ignore = "{
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
  \}"
"let g:ctrlp_match_window = 'bottom,order:ttb'
"let g:ctrlp_switch_buffer = 0
"let g:ctrlp_working_path_mode = 0
"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
"let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

nmap <leader>p :CtrlP<cr>
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>


" ==== Settings For Python ==== "
"
" ==== pymode ====
let g:pymode_breakpoint_bind = '<F9>'
let g:pymode_rope = 0
let g:pymode_lint_cwindow = 0

let g:pymode_lint_todo_symbol = 'TD'
let g:pymode_lint_comment_symbol = 'CC'
let g:pymode_lint_visual_symbol = 'RR'
let g:pymode_lint_error_symbol = 'ER'
let g:pymode_lint_info_symbol = 'II'
let g:pymode_lint_pyflakes_symbol = 'FF'


