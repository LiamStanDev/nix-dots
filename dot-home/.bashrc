# nix
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

# home manager session var
if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi
