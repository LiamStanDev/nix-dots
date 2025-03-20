# This scripts is used for the general setting
# for all environment needs.

# zsh
export HISTFILE=~/.zsh_history

# system
PATH="/usr/bin:/usr/sbin:/usr/libexec:$PATH"

# usr
PATH="$HOME/.local/bin:$PATH"

# fzf
PATH="$HOME/.fzf/bin:$PATH"

# rust
PATH="$HOME/.cargo/bin:$PATH"

# go
PATH="$HOME/go/bin:$HOME/.local/go/bin:$PATH"

# python
# export CONDA_AUTO_ACTIVATE_BASE=true

# dotnet
export DOTNET_ROOT=$HOME/.local/dotnet
PATH="$DOTNET_ROOT:$PATH"
PATH="$HOME/.dotnet/tools:$PATH"

# java
export JAVA_HOME="$HOME/.local/java/jdk-22.0.1"
PATH="$JAVA_HOME/bin:$PATH"

# riscv
PATH="$HOME/.local/riscv/bin:$PATH"

# neovim
PATH="$PATH:$HOME/.local/nvim/bin"
PATH="$PATH:$HOME/.local/nvim-linux64/bin"

# mason servers
# PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

# tmux
export TMUX_TMPDIR=/tmp

# qemu
PATH="$HOME/.local/qemu-9.0.0/build:$PATH"

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
#export NPM_CONFIG_PREFIX=~/.npm-global
#PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

# pdsh
export PDSH_RCMD_TYPE=ssh

export PATH
