if [ `which bash` = "/usr/bin/bash" ]; then
	# minttyならイカを処理する
	test -f ~/.profile && . ~/.profile
	test -f ~/.bashrc && . ~/.bashrc
fi
