#!/bin/bash

declare options=("bash
bash_aliases
dunst
i3
profile
ranger
vim
xresources")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit config file: ')

case "$choice" in
	bash)	choice="$HOME/.bashrc";;
	bash_aliases)	choice="$HOME/.bash_aliases";;
	dunst)	choice="$HOME/.config/dunst/dunstrc";;
	i3)	choice="$HOME/.config/.i3/config";;
	profile)	choice="$HOME/.profile";;
	ranger)	choice="$HOME/.config/ranger/rc.conf";;
	vim)	choice="$HOME/.vimrc";;
	xresources)	choice="$HOME/.Xresources";;
	*)	exit 1;;
esac

$TERMINAL -e $EDITOR "$choice"
