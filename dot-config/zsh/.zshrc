# enable completion
fpath=(~/.config/zsh/completions $fpath)
autoload -Uz compinit
compinit

source ~/.zplug/init.zsh

# plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"
zplug "hlissner/zsh-autopair", defer:2
zplug "jeffreytse/zsh-vi-mode"
zplug "Aloxaf/fzf-tab"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
  fi
fi

zplug load # --verbose

source "$HOME/.config/zsh/exec.zsh"
