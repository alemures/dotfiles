#!/bin/bash

get_xres() {
  xrdb -query | grep $1: | awk '{print $2}'
}

alert_info() {
  notify-send -u normal -t 5000 $1 "$2"
}

alert_error() {
  notify-send -u critical -t 5000 $1 "$2"
}

# nord theme
nord0=$(get_xres background)
nord1=$(get_xres color0)
#nord2=$(get_xres)
nord3=$(get_xres color8)
nord4=$(get_xres foreground)
nord5=$(get_xres color7)
nord6=$(get_xres color15)
nord7=$(get_xres color14)
nord8=$(get_xres color6)
nord9=$(get_xres color12)
#nord10=$(get_xres)
nord11=$(get_xres color1)
#nord12=$(get_xres)
nord13=$(get_xres color11)
nord14=$(get_xres color10)
nord15=$(get_xres color13)
