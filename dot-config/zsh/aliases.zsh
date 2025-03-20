# Colorize grep output
alias grep='grep --color=auto'

# ls
if command -v eza &>/dev/null; then
    alias ls="eza"
    alias l="eza -l"
    alias la="eza -la"
    alias lt="eza --tree"
else
    echo "eza not exist"
    alias l="ls -l"
    alias la="ls -la"
fi

alias fd="fdfind"

# vim and neovim
alias v="vim"
alias nv="nvim"
alias n="nvim"

# tmux
alias t="tmux"
alias tn="tmux new -s"
alias td="tmux detach"
alias ta="tmux attach -t"
alias tk="tmux kill-session -t"

# lazy
alias lzg="lazygit"
alias lzd="lazydocker"

# python
alias p='python3'
alias pm='python3 -m'

# git
alias gl='git log --oneline --graph'
alias glm='git log master --oneline --graph'
alias gt='git stash'
alias gtp='git stash pop'
alias gp='git pull'
alias gP='git push'
alias gc='git commit -m'
alias gC='git commit'
alias gs='git switch'
alias gd='git diff'
alias gdm='git diff master'
alias ga='git add .'
alias gs='git status'
