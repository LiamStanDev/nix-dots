# This scripts is used for the general setting

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # XDG Enviroment
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_DATA_HOME="$HOME/.local/share"
  export XDG_RUNTIME_DIR="/run/user/$UID"
  # Default App
  export EDITOR=nvim
else # macos

fi

# history config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# system
PATH="/usr/bin:/usr/sbin:/usr/libexec:$PATH"

# usr
PATH="$HOME/.local/bin:$PATH"

# fzf
PATH="$HOME/.fzf/bin:$PATH"

# rust
PATH="$HOME/.cargo/bin:$PATH"

export PATH
