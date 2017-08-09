if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/plugged/vim-plug
endif

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin  = has('win32unix')
let s:is_mac     = has('mac')
let s:is_linux   = has('linux')
let s:is_gui     = has('gui_running')
let s:is_cui     = !s:is_gui

if s:is_cygwin && &term =~# '^xterm' && &t_Co < 256
	set t_Co=256
endif

silent! call plug#begin('~/.vim/plugged')

Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'rcmdnk/vim-markdown', { 'for': ['markdown']}
Plug 'rhysd/vim-gfm-syntax', { 'for': ['markdown']}
Plug 'glidenote/memolist.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
Plug 'ctrlpvim/ctrlp.vim'

if s:is_gui
	Plug 'bling/vim-airline'
elseif 16 <= &t_Co
	Plug 'bling/vim-airline'
	let g:airline#extensions#tabline#enabled = 1
endif

" colorscheme
Plug 'tomasr/molokai'
Plug 'keith/parsec.vim'

call plug#end()

filetype plugin indent on

" 構文ハイライト表示
syntax enable
" 行番号表示
set number

if &t_Co < 256
	"colorscheme industry
	colorscheme pablo
else
	colorscheme molokai
endif

set cursorline				" 現在の行を強調表示
" カレントウィンドウにのみ罫線を引く
augroup cursorline
	autocmd!
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
augroup END

set backspace=start,eol,indent		" Backspaceで文字の削除とeol,indentも削除可能に
set whichwrap=b,s,h,l,[,],<,>,~			" カーソルキーでeolをまたげるように
set mouse=							" ターミナルごとに動作が異なるらしいマウス連動はしない
set laststatus=2					" ステータス行を常に表示

" タブ幅
set tabstop=4
set softtabstop=4
set shiftwidth=4

if &term == 'win32'
	set termencoding=cp932
else
	set termencoding=utf-8
endif
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=cp932,utf-8

set shell=bash		" デフォルトのままだとcmd.exe

" 見た目
"" 現在の列を強調表示
"set cursorcolumn

" markdown
hi link htmlItalic LineNr
hi link htmlBold WarningMsg
hi link htmlBoldItalic ErrorMsg
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 対応する括弧表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
set foldlevel=100		" 折り畳みしたくないから100

" Tab
" 不可視文字を可視化
if &term == 'win32'
	set list listchars=tab:>-,trail:･,precedes:<,extends:>
else
	set list listchars=tab:\▸\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
endif

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
" 上下移動「論理行」「表示行」を入れ替え
noremap j gj
noremap k gk
noremap gj j
noremap gk k
" 行末までヤンク
nnoremap Y y$
" 日時入力の補助
inoremap <expr> ,df  strftime('%Y-%m-%dT%H:%M:%S')
inoremap <expr> ,dd  strftime('%Y-%m-%d')
inoremap <expr> ,dt  strftime('%H:%M:%S')
" カーソル下のキーワードをヘルプ表示
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><Enter>
" 最後に変更したテキストを選択
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

" make dir
function! s:MakeDirIfNotExist(directory)
	if !isdirectory(expand(a:directory))
		call mkdir(expand(a:directory),"p")
	endif
endfunction

set swapfile
" スワップ作成済みなら読み取り専用で開く
augroup swapchoice-readonly
	autocmd!
	autocmd SwapExists * let v:swapchoice = 'o'
augroup END
set directory=$HOME/.tmp/vim/swap
call s:MakeDirIfNotExist(&directory)

"File
set hidden      "ファイル変更中でも他のファイルを開けるようにする
set autoread    "ファイル内容が変更されると自動読み込みする

"	backup
set backup
set backupdir=$HOME/.tmp/vim/backup
call s:MakeDirIfNotExist(&backupdir)

"	undo
if has('persistent_undo')
	set undolevels=2000
	set undofile
	set undodir=$HOME/.tmp/vim/undo
	call s:MakeDirIfNotExist(&undodir)
endif

" ファイル名
set statusline=%F
" 変更チェック
set statusline+=%m
" 読み込み専用かどうか
set statusline+=%r
" ヘルプページなら[HELP]
set statusline+=%h
" プレビューウィンドウなら[Preview]
set statusline+=%=
" file encoding
set statusline+=[%{&fileencoding}]
" file type
set statusline+=[%{&filetype}]
" ブランチ名
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
" 現在行数/全行数
set statusline+=[LOW=%l/%L]

let mapleader = "\<Space>"

nnoremap <Leader>ev  :<C-u>tabnew $MYVIMRC<CR>
nnoremap <Leader>rv  :<C-u>source $MYVIMRC<CR>
nnoremap <Leader>ee  :<C-u>NERDTreeToggle<CR>

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>

" memolist
nnoremap <Leader>mn  :<C-u>MemoNew<CR>
nnoremap <Leader>ml  :<C-u>MemoList<CR>
nnoremap <Leader>mg  :<C-u>MemoGrep<CR>
let g:memolist_memo_suffix = "md"
let g:memolist_qfixgrep = 1
let g:memolist_ex_cmd = 'NERDTree'
