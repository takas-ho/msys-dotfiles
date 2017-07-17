set columns=128
set lines=60
colorscheme  desert
set background=dark

if has('kaoriya')
	autocmd GUIEnter * set transparency=240
	set guifont=MS_GOTHIC:h9
	set noundofile
	colorscheme molokai
endif

nnoremap <Leader>eg	:<C-u>tabnew $MYGVIMRC<CR>

" 不可視文字を表示の詳細設定
set listchars=tab:\▸\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

"" clipboardを使いたい
"set clipboard=unnamed

" neobundle導入でGVimメニューが化ける
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

