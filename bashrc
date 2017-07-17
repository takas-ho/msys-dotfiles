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
