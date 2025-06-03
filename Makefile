.PHONY: update
upgrade:
	@echo "🔄 Home updating..."
	@git add .
	@# @home-manager switch --flake .#profile --verbose -b bckp
	@nix run .#switch

.PHONY: update
update:
	@echo "🔄 Home updating..."
	@git add .
	@nix flake update

.PHONY: sysupgrade
	@echo "🔄 System updating..."
	@git add .
	@sudo nixos-rebuild switch

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
