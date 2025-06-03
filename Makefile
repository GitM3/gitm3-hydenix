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
	@echo "$(CYAN)NixOS Management Commands$(NC)"
	@echo "=========================="
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ { printf "$(GREEN)%-15s$(NC) %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

# === Building and Switching ===

rebuild: ## Full rebuild and switch (alias for switch)
	@echo "$(BLUE)🔄 Rebuilding NixOS configuration...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR)

switch: ## Build and switch to new configuration
	@echo "$(BLUE)🔄 Building and switching to new configuration...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR)

test: ## Build and test configuration (no switch)
	@echo "$(YELLOW)🧪 Testing configuration (no switch)...$(NC)"
	sudo nixos-rebuild test --flake $(FLAKE_DIR)

build: ## Build configuration without switching
	@echo "$(BLUE)🔨 Building configuration...$(NC)"
	sudo nixos-rebuild build --flake $(FLAKE_DIR)

dry-run: ## Show what would be built/changed
	@echo "$(CYAN)🔍 Dry run - showing what would change...$(NC)"
	sudo nixos-rebuild dry-run --flake $(FLAKE_DIR)

boot: ## Build and set as boot default (no immediate switch)
	@echo "$(PURPLE)🥾 Setting configuration for next boot...$(NC)"
	sudo nixos-rebuild boot --flake $(FLAKE_DIR)

# === Debugging ===

debug: ## Rebuild with verbose output and trace
	@echo "$(RED)🐛 Debug rebuild with full trace...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR) --show-trace --verbose

check-syntax: ## Check flake syntax without building
	@echo "$(CYAN)📋 Checking flake syntax...$(NC)"
	nix flake check $(FLAKE_DIR)

show: ## Show flake outputs
	@echo "$(CYAN)📄 Showing flake outputs...$(NC)"
	nix flake show $(FLAKE_DIR)

# === Maintenance and Cleanup ===

clean: ## Clean build artifacts older than 30 days
	@echo "$(YELLOW)🧹 Cleaning build artifacts older than 30 days...$(NC)"
	sudo nix-collect-garbage --delete-older-than 30d
	nix-collect-garbage --delete-older-than 30d
	@echo "$(GREEN)✅ Cleanup complete (kept last 30 days)$(NC)"

clean-week: ## Clean build artifacts older than 7 days
	@echo "$(YELLOW)🧹 Cleaning build artifacts older than 7 days...$(NC)"
	sudo nix-collect-garbage --delete-older-than 7d
	nix-collect-garbage --delete-older-than 7d
	@echo "$(GREEN)✅ Cleanup complete (kept last 7 days)$(NC)"

clean-conservative: ## Clean build artifacts older than 90 days (very safe)
	@echo "$(YELLOW)🧹 Conservative cleanup - removing items older than 90 days...$(NC)"
	sudo nix-collect-garbage --delete-older-than 90d
	nix-collect-garbage --delete-older-than 90d
	@echo "$(GREEN)✅ Conservative cleanup complete (kept last 90 days)$(NC)"

deep-clean: ## Aggressive cleanup (removes ALL old generations)
	@echo "$(RED)🗑️  Performing deep cleanup...$(NC)"
	@echo "$(YELLOW)⚠️  WARNING: This will remove ALL old system generations!$(NC)"
	@echo "$(YELLOW)This is irreversible and you won't be able to rollback!$(NC)"
	@read -p "Are you absolutely sure? Type 'yes' to continue: " -r; \
	echo; \
	if [[ $REPLY == "yes" ]]; then \
		sudo nix-collect-garbage -d; \
		nix-collect-garbage -d; \
		echo "$(GREEN)✅ Deep cleanup complete (ALL generations removed)$(NC)"; \
	else \
		echo "$(BLUE)ℹ️  Deep cleanup cancelled$(NC)"; \
	fi

clean-generations: ## Remove system generations older than 30 days (keeps ability to rollback recent changes)
	@echo "$(YELLOW)🗑️  Removing system generations older than 30 days...$(NC)"
	@echo "$(BLUE)ℹ️  This keeps recent generations for rollback capability$(NC)"
	sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +30
	sudo nix-collect-garbage
	@echo "$(GREEN)✅ Old generations cleaned (kept last 30 days)$(NC)"

gc: ## Garbage collect (alias for clean)
	@make clean

optimize: ## Optimize nix store
	@echo "$(BLUE)🚀 Optimizing nix store...$(NC)"
	sudo nix-store --optimise
	@echo "$(GREEN)✅ Store optimization complete$(NC)"

# === Updates ===

update: ## Update flake inputs
	@echo "$(BLUE)📦 Updating flake inputs...$(NC)"
	nix flake update $(FLAKE_DIR)
	@echo "$(GREEN)✅ Flake inputs updated$(NC)"

update-nixpkgs: ## Update only nixpkgs input
	@echo "$(BLUE)📦 Updating nixpkgs...$(NC)"
	nix flake lock --update-input nixpkgs $(FLAKE_DIR)

update-hydenix: ## Update only hydenix input
	@echo "$(BLUE)📦 Updating hydenix...$(NC)"
	nix flake lock --update-input hydenix $(FLAKE_DIR)

upgrade: ## Update and rebuild
	@echo "$(BLUE)🆙 Updating and rebuilding...$(NC)"
	@make update
	@make switch

# === Formatting and Linting ===

format: ## Format nix files
	@echo "$(CYAN)💅 Formatting nix files...$(NC)"
	find . -name "*.nix" -exec nixpkgs-fmt {} \;
	@echo "$(GREEN)✅ Formatting complete$(NC)"

lint: ## Lint nix files
	@echo "$(CYAN)🔍 Linting nix files...$(NC)"
	find . -name "*.nix" -exec statix check {} \; || echo "$(YELLOW)Note: Install 'statix' for linting$(NC)"

# === Backup and Restore ===

backup: ## Backup current configuration
	@echo "$(BLUE)💾 Backing up configuration...$(NC)"
	@mkdir -p $(BACKUP_DIR)
	@cp -r $(FLAKE_DIR) $(BACKUP_DIR)/backup-$(shell date +%Y%m%d-%H%M%S)
	@echo "$(GREEN)✅ Backup saved to $(BACKUP_DIR)$(NC)"

list-generations: ## List system generations
	@echo "$(CYAN)📋 System generations:$(NC)"
	sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

rollback: ## Rollback to previous generation
	@echo "$(YELLOW)⏪ Rolling back to previous generation...$(NC)"
	sudo nixos-rebuild switch --rollback

# === Git Integration ===

git-add: ## Stage all changes for git
	@echo "$(BLUE)📝 Staging changes...$(NC)"
	git add .

git-commit: ## Quick commit with timestamp
	@echo "$(BLUE)📝 Committing changes...$(NC)"
	git add .
	git commit -m "Config update: $(shell date '+%Y-%m-%d %H:%M:%S')"

git-push: ## Push to remote
	@echo "$(BLUE)🚀 Pushing to remote...$(NC)"
	git push

save: ## Quick save: add, commit, push, and rebuild
	@echo "$(PURPLE)💾 Quick save: staging, committing, pushing, and rebuilding...$(NC)"
	@make git-add
	@make git-commit
	@make git-push
	@make switch

# === System Information ===

info: ## Show system information
	@echo "$(CYAN)💻 System Information$(NC)"
	@echo "==================="
	@echo "$(BLUE)Hostname:$(NC) $(HOSTNAME)"
	@echo "$(BLUE)NixOS Version:$(NC) $(shell nixos-version)"
	@echo "$(BLUE)Current Generation:$(NC) $(shell sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -1)"
	@echo "$(BLUE)Flake Location:$(NC) $(PWD)"
	@echo "$(BLUE)Store Size:$(NC) $(shell du -sh /nix/store 2>/dev/null | cut -f1)"

status: ## Show git and system status
	@echo "$(CYAN)📊 Status Overview$(NC)"
	@echo "=================="
	@echo "$(BLUE)Git Status:$(NC)"
	@git status --short || echo "Not a git repository"
	@echo ""
	@echo "$(BLUE)Uncommitted Changes:$(NC)"
	@git diff --name-only || echo "Not a git repository"
	@echo ""
	@make info

# === Quick Actions ===

quick: ## Quick rebuild (skip checks)
	@echo "$(BLUE)⚡ Quick rebuild...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR) --fast

emergency: ## Emergency rebuild with maximum verbosity
	@echo "$(RED)🚨 Emergency rebuild with full debugging...$(NC)"
	sudo nixos-rebuild switch --flake $(FLAKE_DIR) --show-trace --verbose --option eval-cache false

# === Hardware ===

hardware-scan: ## Re-scan hardware configuration
	@echo "$(BLUE)🔧 Scanning hardware configuration...$(NC)"
	sudo nixos-generate-config --show-hardware-config > hardware-configuration-new.nix
	@echo "$(YELLOW)New hardware config saved as hardware-configuration-new.nix$(NC)"
	@echo "$(YELLOW)Review and replace hardware-configuration.nix if needed$(NC)"

# === Monitoring ===

watch-logs: ## Watch system logs during rebuild
	@echo "$(CYAN)📊 Watching system logs...$(NC)"
	journalctl -f

watch-rebuild: ## Watch rebuild process
	watch -n 1 'sudo nixos-rebuild switch --flake . --dry-run | tail -20'

# === Advanced ===

repl: ## Start nix repl with flake
	@echo "$(CYAN)🧠 Starting nix repl...$(NC)"
	nix repl --extra-experimental-features repl-flake $(FLAKE_DIR)

shell: ## Enter development shell
	@echo "$(CYAN)🐚 Entering development shell...$(NC)"
	nix develop $(FLAKE_DIR)

iso: ## Build installation ISO (if configured)
	@echo "$(BLUE)💿 Building installation ISO...$(NC)"
	nix build $(FLAKE_DIR)#nixosConfigurations.iso.config.system.build.isoImage

vm: ## Build and run VM (if configured)
	@echo "$(BLUE)🖥️  Building and starting VM...$(NC)"
	nixos-rebuild build-vm --flake $(FLAKE_DIR)
	./result/bin/run-*-vm
