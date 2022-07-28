# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hN --color=auto --group-directories-first'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias mv='mv -iv'
alias rm='rm -i'
alias cp='cp -iv'
alias mkd='mkdir -pv'
alias of='lsof -nP +c 15 | grep LISTEN'

alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

