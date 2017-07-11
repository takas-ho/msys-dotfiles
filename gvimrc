set guifont=ＭＳ_ゴシック:h10
set columns=128
set lines=60
colorscheme  desert
set background=dark

if has('kaoriya')
	autocmd GUIEnter * set transparency=240
endif

" clipboardを使いたい
set clipboard=unnamed

" neobundle導入でGVimメニューが化ける
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

