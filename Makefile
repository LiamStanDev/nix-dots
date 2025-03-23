.PHONY: update
update:
	@echo "🔄 Updating..."
	@git add .
	@home-manager switch --flake .#profile --verbose -b bckp |& nom --json 
	# @nom build --keep-going --out-link generation .#homeConfigurations.profile.activationPackage --verbose

.PHONY: clean
clean:
	@echo "🧹 Cleaning..."
	@nix-collect-garbage -d

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

.PHONY: status
status:
	@echo "📊 Current Configuration Status:"
	@home-manager packages
