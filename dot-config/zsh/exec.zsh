# source
source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/scripts/enviroment.zsh"
source $HOME/.config/zsh/functions.zsh

# execute
# eval "$(/home/liam/.local/miniconda3/bin/conda shell.zsh hook)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

fix_corrupt
