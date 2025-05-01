# source
source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/functions.zsh"

# execute
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
