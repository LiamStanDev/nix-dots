function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function fix_corrupt() {
    if [ -f $HOME/.zsh_history ]; then
        mv $HOME/.zsh_history $HOME/.zsh_history_bad
        strings $HOME/.zsh_history_bad >$HOME/.zsh_history
        fc -R $HOME/.zsh_history
        if [ -f $HOME/.zsh_history_bad ]; then
            rm $HOME/.zsh_history_bad
        fi
    fi
}
