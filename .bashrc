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

if which go >/dev/null; then
    if [[ $(go env GOBIN) != "" ]]; then
        export PATH="$PATH:$(go env GOBIN)"
    fi

    if [[ ":$PATH:" != *":$(go env GOPATH)/bin:"* ]]; then
        export PATH="$PATH:$(go env GOPATH)/bin"
    fi
fi

if [[ -f $HOME/.cargo/env ]]; then
    . "$HOME/.cargo/env"
fi

if which gh >/dev/null; then
    alias ghmd="gh markdown-preview"
fi

if which xclip >/dev/null; then
    # Should give MIME type when copying (Eg. -t image/png)
    alias xcopy='xclip -selection clipboard'
    alias xpaste='xclip -selection clipboard -o'
fi

if which file >/dev/null; then
    alias mime='file --mime'
fi

if which tmux >/dev/null; then
    if [[ -z ${TMUX} ]]; then
        tmux attach-session -t tasks || tmux new-session -s tasks
    fi
fi

# PATH
export PATH=$PATH:$HOME/bin

# Setting default editor
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

# Environment variables for edtmp script
export _EDTMP_BASE_DIR=${HOME}/edtmp

# Key bindings
# bind '"\C-f": "tmux-sessionizer\n"'
