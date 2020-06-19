#!/bin/bash

. $HOME/.local/bin/nord_theme.sh

IMG_PATH=$HOME/Pictures/scrot
EDIT=gimp
TIME=5000 #Miliseconds notification should remain visible

options='1.quick_fullscreen
2.delayed_fullscreen
3.section
4.edit_fullscreen'

choice=$(echo -e "$options" | dmenu -i -p 'Screenshot Type: ' -fn 'Ubuntu Mono:size=12' -sb "$nord8" -nb "$nord0" -nf "$nord4" -sf "$nord3")

mkdir -p $IMG_PATH
cd $IMG_PATH

FILENAME='%Y-%m-%d-@%H-%M-%S.png'
TITLE='Scrot'
MSG="Screenshot saved in $IMG_PATH"

case $choice in
	1.quick_fullscreen)	scrot -d 1 $FILENAME && notify-send -u low -t $TIME $TITLE "$MSG";;
	2.delayed_fullscreen)	scrot -d 4 $FILENAME && notify-send -u low -t $TIME $TITLE "$MSG";;
	3.section)		scrot -s $FILENAME && notify-send -u low -t $TIME $TITLE "$MSG";;
	4.edit_fullscreen)	scrot -d 1 $FILENAME -e "$EDIT \$f" && notify-send -u low -t $TIME $TITLE "$MSG";;
  	*)			exit 1;;
esac
