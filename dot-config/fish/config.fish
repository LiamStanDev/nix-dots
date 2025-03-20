############################
#       Fish Setup         #
############################
# disable greeting
set fish_greeting ""

# switch vi mode
fish_vi_key_bindings

# theme
fish_config theme choose "Catppuccin Frappe"

############################
#           PATH           #
############################
# add path (this will prepend to $PATH)
fish_add_path "$HOME/.local/bin"
#fish_add_path "$HOME/.fzf/bin"
#fish_add_path "$HOME/.cargo/bin"
#fish_add_path "$HOME/go/bin"
#fish_add_path "$HOME/.local/go/bin"
#fish_add_path "$HOME/.local/nvim/bin"
# fish_add_path "$HOME/.local/nvim-linux64/bin"
# fish_add_path "$HOME/.local/qemu-9.0.0/build"

############################
#        Functions         #
############################
# yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# bash wrapper
function b
    if not type -q babelfish
        echo "🚨 Warning: 'babelfish' is not installed."
    end
    echo $argv | babelfish | source
end


############################
#             Env          #
############################
# let nix don't handle the environment
b source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

switch $(uname)
    case Linux
        # XDG Enviroment
        set -gx XDG_CONFIG_HOME $HOME/.config
        set -gx XDG_CACHE_HOME $HOME/.cache
        set -gx XDG_DATA_HOME $HOME/.local/share
        set -gx XDG_RUNTIME_DIR /run/user/$(id -u)
        # User Directory
        set -gx XDG_DESKTOP_DIR $HOME/Desktop
        set -gx XDG_DOWNLOAD_DIR $HOME/Downloads
        set -gx XDG_TEMPLATES_DIR $HOME/Templates
        set -gx XDG_PUBLICSHARE_DIR $HOME/Public
        set -gx XDG_DOCUMENTS_DIR $HOME/Documents
        set -gx XDG_MUSIC_DIR $HOME/Music
        set -gx XDG_PICTURES_DIR $HOME/Pictures
        set -gx XDG_VIDEOS_DIR $HOME/Videos
    case Darwin
    case '*'
end


set -gx DOTFILES $HOME/dotfiles

# default app
set -gx EDITOR nvim


############################
#       Abbreviations      #
############################
abbr -a grep "grep --color=auto"

# ls
if type -q eza
    abbr -a ls "eza"
    abbr -a ll "eza -l"
    abbr -a la "eza -la"
    abbr -a lt "eza --tree"
else
    abbr -a ll "ls -l"
    abbr -a la "ls -la"
    abbr -a lt "tree"
end

# vim and neovim
abbr -a v "vim"
abbr -a n "nvim"
abbr -a nv "nvim"

# lazy
abbr -a lzg "lazygit"
abbr -a lzd "lazydocker"

# python
abbr -a p "python3"
abbr -a pm "python3 -m"

# git
abbr -a gl "git log --oneline --graph"
abbr -a gt "git stash"
abbr -a gtp "git stash pop"
abbr -a gp "git pull"
abbr -a gP "git push"
abbr -a gc "git commit -m"
abbr -a gca "git commit -am"
abbr -a gC "git commit"
abbr -a gs "git switch"
abbr -a gd "git diff"
abbr -a gdm "git diff master"
abbr -a gs "git status --short --branch --renames"

############################
#           Exec           #
############################
if type -q zoxide
    zoxide init fish | source
else 
    echo "🚨 Warning: 'zoxide' is not installed."
end

# uv and uvx
if type -q uv
    uv generate-shell-completion fish | source
    uvx --generate-shell-completion fish | source
else 
    echo "🚨 Warning: 'uv' is not installed."
end

# fzf
if type -q fzf
    fzf --fish | source
else
    echo "🚨 Warning: 'fzf' is not installed."
end

# starship
if type -q starship
    starship init fish | source
else
    echo "🚨 Warning: 'starship' is not installed."
end

# direnv
if type -q direnv
    direnv hook fish | source
    # trigger direnv at prompt, and on every arrow-based directory change
    set -g direnv_fish_mode eval_on_arrow 
else
    echo "🚨 Warning: 'direnv' is not installed."
end
