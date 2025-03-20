# This scripts is used for setting up platform specific
# setting.

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # XDG Enviroment
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_RUNTIME_DIR="/run/user/$UID"
    # User Directory
    export XDG_DESKTOP_DIR="$HOME/Desktop"
    export XDG_DOWNLOAD_DIR="$HOME/Downloads"
    export XDG_TEMPLATES_DIR="$HOME/Templates"
    export XDG_PUBLICSHARE_DIR="$HOME/Public"
    export XDG_DOCUMENTS_DIR="$HOME/Documents"
    export XDG_MUSIC_DIR="$HOME/Music"
    export XDG_PICTURES_DIR="$HOME/Pictures"
    export XDG_VIDEOS_DIR="$HOME/Videos"
    # Default App
    export EDITOR=nvim

    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    fi

    if [[ "$DESKTOP_SESSION" == "niri" ]]; then
        # vscode for wayland
        alias code="code --password-store=gnome-libsecret --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations"
    fi
else # macos

fi
