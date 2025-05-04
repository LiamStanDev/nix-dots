# This scripts is used for the general setting

# history config
HISTSIZE=10000
SAVEHIST=100000
HISTFILE=~/.cache/.zsh_history

# system
PATH="$PATH:/usr/bin:/usr/sbin:/usr/libexec"

# nodejs
export PNPM_HOME="$HOME/.pnpm"
PATH="$PNPM_HOME:$PATH"

# usr
PATH="$HOME/.local/bin:$PATH"

# rust
PATH="$HOME/.cargo/bin:$PATH"

export PATH
