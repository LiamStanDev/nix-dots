.PHONY: check
check:
	@echo "🔄 Flake check..."
	@git add .
	@nix flake check

.PHONY: upgrade
upgrade:
	@echo "🔄 Full upgrading..."
	@git add .
	@sudo nix run .#switch 


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


.PHONY: install
install:
	@./scripts/install

.PHONY: uninstall
uninstall:
	@./scripts/uninstall
