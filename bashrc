alias ll='ls --color=auto --show-control-chars -alF'
alias ls='ls --color=auto --show-control-chars'
alias la='ls --color=auto --show-control-chars -A'
alias l='ls --color=auto --show-control-chars -CF'
#alias ex='start .'
if [ -f ~/bin/ssh-homma@daniel-soft ]; then
	source ~/bin/ssh-homma@daniel-soft
fi
alias gvimnew=$HOME/bin/gvim
alias gvim="gvimnew --remote-tab-silent"
if [ `which bash` = "/usr/bin/bash" ]; then
	# git2.xだと、git mergeでeditorが動くので抑止する
	export GIT_MERGE_AUTOEDIT=no
	# unstage状態を`*`表示
	export GIT_PS1_SHOWDIRTYSTATE=true
fi

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

