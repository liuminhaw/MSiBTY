#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if which gh > /dev/null; then
    eval "$(gh completion -s bash)"
fi

