#! /bin/env bash

function setup_git {
	git config --global credential.helper store
	git config --global user.name "congnghiahieu"
	git config --global user.email "2102540@vnu.edu.vn"
}

function setup_vim {
	cp -r ../.vim ~/.vim
	cp ../.vimrc ~/.vimrc
}

function setup_konsole {
	cp -r ../konsole ~/.local/share/
}

function setup_tmux {
	cp -r ../.tmux ~/.tmux
	cp ../.tmux.conf ~/.tmux.conf
}

function setup_fzf {
	cp ../.fzf/key-bindings.zsh ~/.fzf/shell/key-bindings.zsh
}
