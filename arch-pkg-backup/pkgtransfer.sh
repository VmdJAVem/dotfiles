#!/bin/bash
# arch-pkg-transfer: Transfer Arch Linux packages between machines
# Ignores EndevourOS base packages

set -e

BACKUP_DIR="$HOME/arch-pkg-backup"
OFFICIAL_LIST="$BACKUP_DIR/official_pkglist.txt"
AUR_LIST="$BACKUP_DIR/aur_pkglist.txt"
ENDEAVOUROS_IGNORE_LIST="$BACKUP_DIR/endeavouros_ignored.txt"

# Common EndevourOS package patterns and base packages to ignore
ENDEAVOUROS_PACKAGES=(
	# Desktop environment and display manager
	"endeavouros"
	"eos-*"
	"firefox-endeavouros"
	"lightdm-*-endeavouros"
	"sddm-*-endeavouros"

	# EOS-specific tools and utilities
	"eos-*"
	"endeavouros-*"
	"eos-*-config"
	"eos-*-theme"

	# EOS wallpapers and theming
	"endeavouros-wallpapers"
	"endeavouros-skel*"
	"eos-wallpapers"
	"eos-skel*"

	# EOS Welcome and setup
	"welcome"
	"eos-welcome"
	"endeavouros-welcome"

	# EOS update notifier
	"eos-update-notifier"
	"endeavouros-notifier"

	# EOS pacman hook and configs
	"eos-hooks"
	"eos-pacman-hook"
	"endeavouros-hooks"

	# EOS scripts and utilities
	"eos-*script*"
	"endeavouros-*script*"
	"eos-rankmirrors"

	# EOS live session packages
	"eos-live*"
	"endeavouros-live*"

	# Common EOS meta-packages
	"eos-meta*"
	"endeavouros-meta*"
)

help() {
	echo "Usage: $0 [--backup|--restore|--install-aur-helper|--list-eos-packages]"
	echo
	echo "Options:"
	echo "  --backup              Create package lists in $BACKUP_DIR (excluding EndevourOS packages)"
	echo "  --restore             Install packages from existing lists"
	echo "  --install-aur-helper  Install paru AUR helper"
	echo "  --list-eos-packages   List installed EndevourOS packages that will be ignored"
	echo
	echo "Backup files will be saved to: $BACKUP_DIR"
}

# Function to check if a package should be ignored (EndevourOS package)
should_ignore_package() {
	local pkg="$1"

	# Check if package name matches any EndevourOS pattern
	for pattern in "${ENDEAVOUROS_PACKAGES[@]}"; do
		if [[ "$pattern" == *"*"* ]]; then
			# Handle wildcard patterns
			pattern_regex="${pattern//\*/.*}"
			if [[ "$pkg" =~ ^${pattern_regex}$ ]]; then
				return 0 # Should be ignored
			fi
		elif [[ "$pkg" == "$pattern" ]]; then
			return 0 # Should be ignored
		fi
	done

	# Additional check: packages from endeavouros repository
	if pacman -Qi "$pkg" 2>/dev/null | grep -q "Repository.*endeavouros"; then
		return 0 # Should be ignored
	fi

	return 1 # Should not be ignored
}

backup_packages() {
	echo "Creating backup directory: $BACKUP_DIR"
	mkdir -p "$BACKUP_DIR"

	echo "Identifying and ignoring EndevourOS packages..."
	>"$ENDEAVOUROS_IGNORE_LIST" # Clear the file

	# Get all explicitly installed packages
	ALL_EXPLICIT_PKGS=$(pacman -Qqe | sort)

	# Separate official and AUR packages
	ALL_OFFICIAL_PKGS=$(comm -23 <(echo "$ALL_EXPLICIT_PKGS") <(pacman -Qqm | sort))
	ALL_AUR_PKGS=$(pacman -Qqm | sort)

	# Filter out EndevourOS packages from official packages
	echo "Filtering official packages (excluding EndevourOS)..."
	>"$OFFICIAL_LIST"
	for pkg in $ALL_OFFICIAL_PKGS; do
		if should_ignore_package "$pkg"; then
			echo "$pkg" >>"$ENDEAVOUROS_IGNORE_LIST"
		else
			echo "$pkg" >>"$OFFICIAL_LIST"
		fi
	done

	# Filter out EndevourOS packages from AUR packages
	echo "Filtering AUR packages (excluding EndevourOS)..."
	>"$AUR_LIST"
	for pkg in $ALL_AUR_PKGS; do
		if should_ignore_package "$pkg"; then
			echo "$pkg" >>"$ENDEAVOUROS_IGNORE_LIST"
		else
			echo "$pkg" >>"$AUR_LIST"
		fi
	done

	# Sort the files
	sort -o "$OFFICIAL_LIST" "$OFFICIAL_LIST"
	sort -o "$AUR_LIST" "$AUR_LIST"
	sort -o "$ENDEAVOUROS_IGNORE_LIST" "$ENDEAVOUROS_IGNORE_LIST"

	# Count packages
	official_count=$(wc -l <"$OFFICIAL_LIST" | tr -d ' ')
	aur_count=$(wc -l <"$AUR_LIST" | tr -d ' ')
	ignored_count=$(wc -l <"$ENDEAVOUROS_IGNORE_LIST" | tr -d ' ')

	echo -e "\nPackage backup complete:"
	echo "Official packages saved: $official_count"
	echo "AUR packages saved:      $aur_count"
	echo "EndevourOS packages ignored: $ignored_count"
	echo -e "\nFiles created in $BACKUP_DIR:"
	echo "Official packages: $OFFICIAL_LIST"
	echo "AUR packages:      $AUR_LIST"
	echo "Ignored packages:  $ENDEAVOUROS_IGNORE_LIST"
	echo -e "\nTransfer these files to your new machine."
}

restore_packages() {
	if [[ ! -f "$OFFICIAL_LIST" ]]; then
		echo "Error: Package list not found: $OFFICIAL_LIST"
		echo "Copy your backup files to $BACKUP_DIR and try again"
		exit 1
	fi

	echo "Updating system..."
	sudo pacman -Syu --noconfirm

	# Check if we have AUR packages to restore
	if [[ -f "$AUR_LIST" ]] && [[ -s "$AUR_LIST" ]]; then
		echo -e "\nChecking for AUR helper..."
		if ! command -v paru &>/dev/null && ! command -v paru &>/dev/null; then
			echo "No AUR helper found. Install one first with:"
			echo "  $0 --install-aur-helper"
			exit 1
		fi
	fi

	echo -e "\nInstalling official packages..."
	if [[ -s "$OFFICIAL_LIST" ]]; then
		sudo pacman -S --needed --noconfirm - <"$OFFICIAL_LIST"
	else
		echo "No official packages to install (list is empty)"
	fi

	echo -e "\nInstalling AUR packages..."
	if [[ -f "$AUR_LIST" ]] && [[ -s "$AUR_LIST" ]]; then
		if command -v paru &>/dev/null; then
			paru -S --needed --noconfirm - <"$AUR_LIST"
		elif command -v paru &>/dev/null; then
			paru -S --needed --noconfirm - <"$AUR_LIST"
		fi
	else
		echo "No AUR packages to install"
	fi

	echo -e "\nPackage restoration complete!"
	echo "Note: EndevourOS packages were not restored (as intended)"
}

install_aur_helper() {
	echo "Installing paru AUR helper..."
	sudo pacman -S --needed --noconfirm git base-devel
	mkdir -p ~/aur
	cd ~/aur
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
}

list_eos_packages() {
	echo "Installed EndevourOS packages (these will be ignored during backup):"
	echo "===================================================================="

	# Check all installed packages against our ignore patterns
	ALL_PKGS=$(pacman -Qq)
	EOS_FOUND=0

	for pkg in $ALL_PKGS; do
		if should_ignore_package "$pkg"; then
			# Get package description
			desc=$(pacman -Qi "$pkg" 2>/dev/null | grep -m1 "Description" | cut -d: -f2- | xargs || echo "No description")
			# Get repository
			repo=$(pacman -Qi "$pkg" 2>/dev/null | grep "Repository" | cut -d: -f2- | xargs || echo "unknown")

			printf "%-30s %-20s %s\n" "$pkg" "[$repo]" "$desc"
			EOS_FOUND=1
		fi
	done

	if [[ $EOS_FOUND -eq 0 ]]; then
		echo "No EndevourOS packages found (or not running on EndevourOS)"
	fi
}

case "$1" in
"--backup")
	backup_packages
	;;
"--restore")
	restore_packages
	;;
"--install-aur-helper")
	install_aur_helper
	;;
"--list-eos-packages")
	list_eos_packages
	;;
*)
	help
	exit 1
	;;
esac
