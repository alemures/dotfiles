sudo apt install xorg i3

Autostart X at login with following lines at the bottom of .profile
```
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
```

Handle volume with amixer from following package
```
sudo apt show alsa-utils

amixer set Master mute
amixer set Master unmute
amixer set Master toggle

amixer set Master 50%
```

Fonts and style (from contrib non-free repos)
`sudo apt install fonts-ubuntu`
set wallpaper using hsetroot
`sudo apt install hsetroot`
Place the i3 config file in ~/.config/i3/config
Place the file .Xresources ~/

Later run super+shift+c to reload i3 and reload xresources with:
`xrdb .Xresources`

Nice terminal file manager
`apt install ranger`

Enable image preview adding following lines to ~/.config/ranger/rc.conf
```
set preview_images true
set preview_images_method urxvt
```

Nice tools: neofetch, pstree
