# environment variables
source "$HOME/.config/zsh/exports.zsh"

# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# enable completion
zi light "zsh-users/zsh-completions"
zi ice as"completion"
zi snippet OMZP::docker/completions/_docker
zi ice as"completion"
zi snippet OMZP::docker-compose/_docker-compose
zi ice as"completion"
zi snippet https://raw.githubusercontent.com/sharkdp/fd/master/contrib/completion/_fd
zi ice mv"bun.zsh -> _bun" as"completion"
zi snippet https://raw.githubusercontent.com/oven-sh/bun/main/completions/bun.zsh
fpath=(~/.config/zsh/completions $fpath)
autoload -Uz compinit
compinit

# plugins
zi light "zsh-users/zsh-history-substring-search"
zi light "zsh-users/zsh-autosuggestions"
zi light "zdharma/fast-syntax-highlighting"
zi light "hlissner/zsh-autopair"
zi light "jeffreytse/zsh-vi-mode"
zi light "Aloxaf/fzf-tab"

# static config
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/functions.zsh"

# exec
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
