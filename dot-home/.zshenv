# zsh config dir
export ZDOTDIR=$HOME/.config/zsh
. "$HOME/.cargo/env"

if [ -e /home/liam/.nix-profile/etc/profile.d/nix.sh ]; then . /home/liam/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
