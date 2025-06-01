.PHONY: link unlink

link:
	@stow -v --target ~/.config --ignore=Makefile --ignore=fonts .
	@ln -sf $(shell pwd)/fonts ~/.local/share/fonts
	@fc-cache -f


unlink:
	@stow -v --target ~/.config --ignore=Makefile -D .
	@rm -f ~/.local/share/fonts
	@fc-cache -f