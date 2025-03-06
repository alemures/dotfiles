# Default programs
export TERMINAL='urxvtc'
export EDITOR='vim'
export BROWSER='google-chrome'
export QT_QPA_PLATFORMTHEME=qt5ct

# From tzselec
export TZ='Europe/Madrid'

# Create nvm env variable and make node and npm available system wise
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# if running bash source .bashrc
if [ -n "$BASH_VERSION" ]; then
    . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

PATH="/usr/sbin:$PATH"

# Autostart i3 on login
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
