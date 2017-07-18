if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

" neobundle.vim 自身をneobundle.vimで管理する
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'rhysd/vim-gfm-syntax'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'tpope/vim-fugitive'

" color
NeoBundle 'tomasr/molokai'

call neobundle#end()

filetype plugin indent on
" プラグインがインストールされているかチェック
NeoBundleCheck

if !has('vim_starting')
	" .vimrcを読み込み直したときのための設定
	call neobundle#call_hook('on_source')
endif

" コードの色分け
syntax enable

"colorscheme industry
colorscheme pablo

set tabstop=4
set softtabstop=4
set shiftwidth=4

set encoding=utf-8
set termencoding=cp932
set fileencoding=utf-8
set fileencodings=utf-8,sjis

" 見た目
" 行番号表示
set number
"" 現在の行を強調表示
set cursorline
"" 現在の列を強調表示
"set cursorcolumn
" カレントウィンドウにのみ罫線を引く
augroup cursorline
	autocmd!
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
augroup END
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

" Tab
" 不可視文字を可視化
set list listchars=tab:>-,trail:･,precedes:<,extends:>

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

function! s:MakeDirIfNotExist(directory)
	if !isdirectory(expand(a:directory))
		call mkdir(expand(a:directory), 'p')
	endif
endfunction

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

" swap file
set directory=$HOME/.tmp/vim/swap
call s:MakeDirIfNotExist(&directory)

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

nnoremap <Leader>ev	:<C-u>tabnew $MYVIMRC<CR>

" memolist
nnoremap <Leader>mn  :<C-u>MemoNew<CR>
nnoremap <Leader>ml  :<C-u>MemoList<CR>
nnoremap <Leader>mg  :<C-u>MemoGrep<CR>
let g:memolist_memo_suffix = "md"
let g:memolist_qfixgrep = 1
let g:memolist_unite = 1
let g:memolist_unite_source = "file_rec"
let g:memolist_unite_option = "-auto-preview -start-insert"
