.PHONY: link
link:
	@stow -v --target ~ home
	@stow -v --target ~/.config config
	@stow -v --target ~/.local/share local
	@fc-cache -f

.PHONY: unlink
unlink:
	@stow -v --target ~ -D home
	@stow -v --target ~/.config -D config
	@stow -v --target ~/.local/share -D local
	@fc-cache -f
