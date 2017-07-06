" コードの色分け
syntax on

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
"set cursorline
"" 現在の列を強調表示
"set cursorcolumn
" カレントウィンドウにのみ罫線を引く
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=blue guibg=black
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
set list listchars=tab:>-,trail:.,precedes:<,extends:>,eol:$

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

