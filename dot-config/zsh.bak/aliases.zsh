alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'

alias reload="source ~/.config/zsh/.zshrc"

alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'

# Colorize grep output
alias grep='grep --color=auto'

# ls
if command -v eza &>/dev/null; then
  alias ls="eza"
  alias ll="eza -l"
  alias la="eza -la"
  alias lt="eza --tree"
  alias lR="eza -lR"
else
  echo "eza not exist"
  alias ll="ls -l"
  alias la="ls -la"
fi

alias rm="trash"
alias sys="systemctl"
alias mkdir="mkdir -p"

# alias fd="fdfind"

# vim and neovim
alias v="vim"
alias n="nvim"
alias nv="nvim"

# lazy
alias lzg="lazygit"
alias lzd="lazydocker"

# nodejs
alias pn="pnpm"

# git
alias gl='git log --graph --decorate --pretty=oneline --abbrev-commit --all'
alias gC='git commit'
alias gP='git publish'
alias ga='git add .'
alias gc='git commit -m'
alias gca='git commit -am'
alias gd='git diff'
alias gdm='git diff master'
alias gl='git log --graph --decorate --pretty=oneline --abbrev-commit --all'
alias gp='git pull'
alias gs='git status --short --branch --renames'
alias gt='git stash'
alias gtp='git stash pop'
