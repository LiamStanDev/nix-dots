.PHONY: upgrade
upgrade:
	@echo "🔄 Full upgrading..."
	@git add .
	@nix run .#switch-os # nixos-rebuild switch --flake .#laptop --verbose
	@nix run .#switch-home  # home-manager switch --flake .#profile --verbose -b bckp

.PHONY: hmupgrade
hmupgrade:
	@echo "🔄 Home upgrading..."
	@git add .
	@nix run .#switch-home # home-manager switch --flake .#profile --verbose -b bckp

.PHONY: sysupgrade
sysupgrade:
	@echo "🔄 System upgrading..."
	@git add .
	@nix run .#switch-os # sudo nixos-rebuild switch --flake .#laptop --verbose

.PHONY: update
update:
	@echo "🔄 Flake channel updating..."
	@git add .
	@nix flake update

.PHONY: clean
clean:
	@echo "🧹 Cleaning..."
	@nix-collect-garbage -d

.PHONY: link
link:
	@echo "📦 Link Config..."
	@cd dot-home && make
	@cd dot-config && make
	@cd dot-desktop && make
	@echo "✅ Config files linked successfully"

.PHONY: unlink
unlink:
	@echo "📦 Unlink Config..."
	@cd dot-home && make unlink
	@cd dot-config && make unlink
	@cd dot-desktop && make unlink
	@echo "✅ Config files unliked successfully"


.PHONY: link-minimal
link-minimal:
	@echo "📦 Link Config..."
	@cd dot-home && make
	@cd dot-config && make
	@echo "✅ Config files linked successfully"

.PHONY: unlink-minimal
unlink-minimal:
	@echo "📦 Unlink Config..."
	@cd dot-home && make unlink
	@cd dot-config && make unlink
	@echo "✅ Config files unliked successfully"

.PHONY: status
status:
	@echo "📊 Current Configuration Status:"
	@home-manager packages


.PHONY: install
install:
	@./scripts/install


.PHONY: uninstall
uninstall:
	@./scripts/uninstall
