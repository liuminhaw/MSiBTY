#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if which gh > /dev/null; then
    eval "$(gh completion -s bash)"
fi

if which fzf > /dev/null; then
    eval "$(fzf --bash)"
fi

