#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim=nvim

# PS1='[\u@\h \W]\$ '
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

if which go > /dev/null; then
    if [[ $(go env GOBIN) != "" ]]; then
        export PATH="$PATH:$(go env GOBIN)"
    fi

    if [[ ":$PATH:" != *":$(go env GOPATH)/bin:"* ]]; then
        export PATH="$PATH:$(go env GOPATH)/bin" 
    fi
fi

if which gh > /dev/null; then
    alias ghmd="gh markdown-preview"
fi

# Setting default editor
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
