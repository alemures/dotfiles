#!/bin/bash

. $HOME/.local/bin/nord_theme.sh

options='bash
bash_aliases
dunst
i3
profile
ranger
vim
xresources'

choice=$(echo -e "$options" | dmenu -i -p 'Edit config file: ' -fn 'Ubuntu Mono:size=12' -sb "$nord8" -nb "$nord0" -nf "$nord4" -sf "$nord3")

case $choice in
	bash)		file="$HOME/.bashrc";;
	bash_aliases)	file="$HOME/.bash_aliases";;
	dunst)		file="$HOME/.config/dunst/dunstrc";;
	i3)		file="$HOME/.config/i3/config";;
	profile)	file="$HOME/.profile";;
	ranger)		file="$HOME/.config/ranger/rc.conf";;
	vim)		file="$HOME/.vimrc";;
	xresources)	file="$HOME/.Xresources";;
	*)		exit 1;;
esac

$TERMINAL -e $EDITOR $file
