.PHONY: update
update:
	@echo "🔄 Updating..."
	@home-manager switch --flake .#profile --verbose

.PHONY: clean
clean:
	@echo "🧹 Cleaning..."
	@nix-collect-garbage -d

.PHONY: install-nix
install-nix:
	@echo "📦 Installing Nix..."
	@if [ -z "$$BASH_VERSION" ]; then echo "Please run 'chsh -s /bin/bash' first"; exit 1; fi
	@sh <(curl -L https://nixos.org/nix/install) --no-daemon
	@echo "✅ Nix Installed!"

.PHONY: install-hm
install-hm:
	@echo "📦 Installing Home Manager..."
	@nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	@nix-channel --update
	@nix-shell '<home-manager>' -A install
	@echo 'experimental-features = nix-command flakes' > ~/.config/nix/nix.conf
	@echo "✅ Home Manager Installed!"

.PHONY: uninstall-nix
uninstall-nix:
	@echo "📦 Uninstalling Nix..."
	@sudo rm -rf /nix # single user

.PHONY: link
link:
	@echo "📦 Link Config..."
	@cd dot-home && make
	@cd dot-config && make
	@echo "✅ Config files linked successfully"

.PHONY: unlink
unlink:
	@echo "📦 Unlink Config..."
	@cd dot-home && make unlink
	@cd dot-config && make unlink
	@echo "✅ Config files unliked successfully"

.PHONY: install
install:
	@make link
	@make install-nix
	@make install-hm
	@make unlink
	@make link
	@make update
	@echo "🎉 Installation Complete! You can use $(shell chsh -s /bin/fish)."

.PHONY: uninstall
uninstall:
	@make unlink
	@make uninstall-nix
	@echo "🎉 Uninstallation Complete!"

.PHONY: status
status:
	@echo "📊 Current Configuration Status:"
	@home-manager packages
