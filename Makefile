.PHONY: check
check:
	@echo "🔄 Flake check..."
	@git add .
	@nix flake check

# .PHONY: upgrade
# upgrade:
# 	@echo "🔄 Full upgrading..."
# 	@git add .
# 	@sudo nixos-rebuild switch --flake .#<host> |& nom && make link
# 	@make link


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
	@cd dots && make
	@echo "✅ Config files linked successfully"

.PHONY: unlink
unlink:
	@echo "📦 Unlink Config..."
	@cd dots && make unlink
	@echo "✅ Config files unliked successfully"



.PHONY: install
install:
	@./scripts/install

.PHONY: uninstall
uninstall:
	@./scripts/uninstall
