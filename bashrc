alias ll='ls --color=auto --show-control-chars -alF'
alias ls='ls --color=auto --show-control-chars'
alias la='ls --color=auto --show-control-chars -A'
alias l='ls --color=auto --show-control-chars -CF'
if [ "$CONEMUPID" != "" ]; then
	/c/windows/system32/chcp.com 65001
fi
#alias ex='start .'
if [ -f ~/bin/ssh-homma@daniel-soft ]; then
	source ~/bin/ssh-homma@daniel-soft
fi
alias gvimnew=$HOME/bin/gvim
alias gvim="gvimnew --remote-tab-silent"
if [ `which bash` = "/usr/bin/bash" ]; then
	# git2.xだと、git mergeでeditorが動くので抑止する
	export GIT_MERGE_AUTOEDIT=no
fi
# unstage状態を`*`表示
export GIT_PS1_SHOWDIRTYSTATE=true

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

