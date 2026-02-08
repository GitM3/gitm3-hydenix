# NixOS Management Makefile
# Place this in your flake directory (where flake.nix is located)

.PHONY: help rebuild switch test build clean gc update check format lint backup restore

# Default target
.DEFAULT_GOAL := help

# Configuration
FLAKE_DIR := .
HOSTNAME := $(shell hostname)
BACKUP_DIR := ~/nixos-backups

# Colors for pretty output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
PURPLE := \033[0;35m
CYAN := \033[0;36m
NC := \033[0m # No Color

help: ## Show this help message
	@printf "$(CYAN)NixOS Management Commands$(NC)"
	@printf "=========================="
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ { printf "$(GREEN)%-15s$(NC) %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

# === Building and Switching ===

rebuild: ## Full rebuild and switch (alias for switch)
	@printf "$(BLUE)🔄 Rebuilding NixOS configuration...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR)

switch: ## Build and switch to new configuration
	@printf "$(BLUE)🔄 Git add, Building and switching to new configuration...$(NC)"
	git add .
	sudo nixos-rebuild switch --flake $(FLAKE_DIR)

test: ## Build and test configuration (no switch)
	@printf "$(YELLOW)🧪 Testing configuration (no switch)...$(NC)"
	sudo nixos-rebuild test --flake $(FLAKE_DIR)

build: ## Build configuration without switching
	@printf "$(BLUE)🔨 Building configuration...$(NC)"
	sudo nixos-rebuild build --flake $(FLAKE_DIR)

dry-run: ## Show what would be built/changed
	@printf "$(CYAN)🔍 Dry run - showing what would change...$(NC)"
	sudo nixos-rebuild dry-run --flake $(FLAKE_DIR)

boot: ## Build and set as boot default (no immediate switch)
	@printf "$(PURPLE)🥾 Setting configuration for next boot...$(NC)"
	sudo nixos-rebuild boot --flake $(FLAKE_DIR)

# === Debugging ===

debug: ## Rebuild with verbose output and trace
	@printf "$(RED)🐛 Debug rebuild with full trace...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR) --show-trace --verbose

check-syntax: ## Check flake syntax without building
	@printf "$(CYAN)📋 Checking flake syntax...$(NC)"
	nix flake check $(FLAKE_DIR)

show: ## Show flake outputs
	@printf "$(CYAN)📄 Showing flake outputs...$(NC)"
	nix flake show $(FLAKE_DIR)

# === Maintenance and Cleanup ===

clean: ## Clean build artifacts older than 30 days
	@printf "$(YELLOW)🧹 Cleaning build artifacts older than 30 days...$(NC)"
	sudo nix-collect-garbage --delete-older-than 30d
	nix-collect-garbage --delete-older-than 30d
	@printf "$(GREEN)✅ Cleanup complete (kept last 30 days)$(NC)"

clean-week: ## Clean build artifacts older than 7 days
	@printf "$(YELLOW)🧹 Cleaning build artifacts older than 7 days...$(NC)"
	sudo nix-collect-garbage --delete-older-than 7d
	nix-collect-garbage --delete-older-than 7d
	@printf "$(GREEN)✅ Cleanup complete (kept last 7 days)$(NC)"

clean-conservative: ## Clean build artifacts older than 90 days (very safe)
	@printf "$(YELLOW)🧹 Conservative cleanup - removing items older than 90 days...$(NC)"
	sudo nix-collect-garbage --delete-older-than 90d
	nix-collect-garbage --delete-older-than 90d
	@printf "$(GREEN)✅ Conservative cleanup complete (kept last 90 days)$(NC)"

deep-clean: ## Aggressive cleanup (removes ALL old generations)
	@printf "$(RED)🗑️  Performing deep cleanup...$(NC)"
	@printf "$(YELLOW)⚠️  WARNING: This will remove ALL old system generations!$(NC)"
	@printf "$(YELLOW)This is irreversible and you won't be able to rollback!$(NC)"
	@read -p "Are you absolutely sure? Type 'yes' to continue: " -r; \
	printf; \
	if [[ $REPLY == "yes" ]]; then \
		sudo nix-collect-garbage -d; \
		nix-collect-garbage -d; \
		printf "$(GREEN)✅ Deep cleanup complete (ALL generations removed)$(NC)"; \
	else \
		printf "$(BLUE)ℹ️  Deep cleanup cancelled$(NC)"; \
	fi

clean-generations: ## Remove system generations older than 14 days (keeps ability to rollback recent changes)
	@printf "$(YELLOW)🗑️  Removing system generations older than 14 days...$(NC)"
	@printf "$(BLUE)ℹ️  This keeps recent generations for rollback capability$(NC)"
	sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +14
	sudo nix-collect-garbage
	@printf "$(GREEN)✅ Old generations cleaned (kept last 14 days)$(NC)"

gc: ## Garbage collect (alias for clean)
	@make clean

optimize: ## Optimize nix store
	@printf "$(BLUE)🚀 Optimizing nix store...$(NC)"
	sudo nix-store --optimise
	@printf "$(GREEN)✅ Store optimization complete$(NC)"

# === Updates ===

update: ## Update flake inputs
	@printf "$(BLUE)📦 Updating flake inputs...$(NC)"
	sudo nix flake update --flake $(FLAKE_DIR)
	@printf "$(GREEN)✅ Flake inputs updated$(NC)"

update-nixpkgs: ## Update only nixpkgs input
	@printf "$(BLUE)📦 Updating nixpkgs...$(NC)"
	sudo nix flake lock --update-input nixpkgs $(FLAKE_DIR)

update-hydenix: ## Update only hydenix input
	@printf "$(BLUE)📦 Updating hydenix...$(NC)"
	sudo nix flake lock --update-input hydenix $(FLAKE_DIR)

upgrade: ## Update and rebuild
	@printf "$(BLUE)🆙 Updating and rebuilding...$(NC)"
	@make update
	@make switch

# === Formatting and Linting ===

format: ## Format nix files
	@printf "$(CYAN)💅 Formatting nix files...$(NC)"
	find . -name "*.nix" -exec nixpkgs-fmt {} \;
	@printf "$(GREEN)✅ Formatting complete$(NC)"

lint: ## Lint nix files
	@printf "$(CYAN)🔍 Linting nix files...$(NC)"
	find . -name "*.nix" -exec statix check {} \; || printf "$(YELLOW)Note: Install 'statix' for linting$(NC)"

# === Backup and Restore ===

backup: ## Backup current configuration
	@printf "$(BLUE)💾 Backing up configuration...$(NC)"
	@mkdir -p $(BACKUP_DIR)
	@cp -r $(FLAKE_DIR) $(BACKUP_DIR)/backup-$(shell date +%Y%m%d-%H%M%S)
	@printf "$(GREEN)✅ Backup saved to $(BACKUP_DIR)$(NC)"

list-generations: ## List system generations
	@printf "$(CYAN)📋 System generations:$(NC)"
	sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

rollback: ## Rollback to previous generation
	@printf "$(YELLOW)⏪ Rolling back to previous generation...$(NC)"
	sudo nixos-rebuild switch --rollback

# === Git Integration ===

git-add: ## Stage all changes for git
	@printf "$(BLUE)📝 Staging changes...$(NC)"
	git add .

git-commit: ## Quick commit with timestamp
	@printf "$(BLUE)📝 Committing changes...$(NC)"
	git add .
	git commit -m "Config update: $(shell date '+%Y-%m-%d %H:%M:%S')"

git-push: ## Push to remote
	@printf "$(BLUE)🚀 Pushing to remote...$(NC)"
	git push

save: ## Quick save: add, commit, push, and rebuild
	@printf "$(PURPLE)💾 Quick save: staging, committing, pushing, and rebuilding...$(NC)"
	@make git-add
	@make git-commit
	@make git-push
	@make switch

# === System Information ===

info: ## Show system information
	@printf "$(CYAN)💻 System Information$(NC)"
	@printf "==================="
	@printf "$(BLUE)Hostname:$(NC) $(HOSTNAME)"
	@printf "$(BLUE)NixOS Version:$(NC) $(shell nixos-version)"
	@printf "$(BLUE)Current Generation:$(NC) $(shell sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -1)"
	@printf "$(BLUE)Flake Location:$(NC) $(PWD)"
	@printf "$(BLUE)Store Size:$(NC) $(shell du -sh /nix/store 2>/dev/null | cut -f1)"

status: ## Show git and system status
	@printf "$(CYAN)📊 Status Overview$(NC)"
	@printf "=================="
	@printf "$(BLUE)Git Status:$(NC)"
	@git status --short || printf "Not a git repository"
	@printf ""
	@printf "$(BLUE)Uncommitted Changes:$(NC)"
	@git diff --name-only || printf "Not a git repository"
	@printf ""
	@make info

# === Quick Actions ===

quick: ## Quick rebuild (skip checks)
	@printf "$(BLUE)⚡ Quick rebuild...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR) --fast

emergency: ## Emergency rebuild with maximum verbosity
	@printf "$(RED)🚨 Emergency rebuild with full debugging...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR) --show-trace --verbose --option eval-cache false

# === Hardware ===

hardware-scan: ## Re-scan hardware configuration
	@printf "$(BLUE)🔧 Scanning hardware configuration...$(NC)"
	sudo nixos-generate-config --show-hardware-config > hardware-configuration-new.nix
	@printf "$(YELLOW)New hardware config saved as hardware-configuration-new.nix$(NC)"
	@printf "$(YELLOW)Review and replace hardware-configuration.nix if needed$(NC)"

# === Monitoring ===

watch-logs: ## Watch system logs during rebuild
	@printf "$(CYAN)📊 Watching system logs...$(NC)"
	journalctl -f

watch-rebuild: ## Watch rebuild process
	watch -n 1 'sudo nixos-rebuild switch --flake . --dry-run | tail -20'

# === Advanced ===

repl: ## Start nix repl with flake
	@printf "$(CYAN)🧠 Starting nix repl...$(NC)"
	nix repl --extra-experimental-features repl-flake $(FLAKE_DIR)

shell: ## Enter development shell
	@printf "$(CYAN)🐚 Entering development shell...$(NC)"
	nix develop $(FLAKE_DIR)

iso: ## Build installation ISO (if configured)
	@printf "$(BLUE)💿 Building installation ISO...$(NC)"
	nix build $(FLAKE_DIR)#nixosConfigurations.iso.config.system.build.isoImage

vm: ## Build and run VM (if configured)
	@printf "$(BLUE)🖥️  Building and starting VM...$(NC)"
	nixos-rebuild build-vm --flake $(FLAKE_DIR)
	./result/bin/run-*-vm
hm-pepadev: ## Build standalone hm in profile/pepadev
	@printf "$(BLUE) Home manager build in profile/pepadev"
	cd ./profiles/pepadev && \
	nix run home-manager/master -- switch --flake .#pepadev
