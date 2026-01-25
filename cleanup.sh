#!/usr/bin/env bash
set -e

BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Deprecated files that should be removed from home directory
DEPRECATED_FILES=(
    "$HOME/.path"
    "$HOME/.exports"
    "$HOME/.aliases"
    "$HOME/.func"
    "$HOME/.zsh_profile"
    "$HOME/.bash_profile"
    "$HOME/.gitconfig"
    "$HOME/.tmux.conf"
    "$HOME/.tern-config"
)

# Flags
DRY_RUN=false
FORCE=false
NO_BACKUP=false

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Remove deprecated dotfiles from home directory that were installed"
    echo "by previous versions of this dotfiles repo."
    echo ""
    echo "Options:"
    echo "  --dry-run     Preview changes without making them"
    echo "  --force       Skip confirmation prompts"
    echo "  --no-backup   Remove files without backing them up first"
    echo "  -h, --help    Show this help message"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --no-backup)
            NO_BACKUP=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Find deprecated files that exist
find_existing() {
    local found=()
    for file in "${DEPRECATED_FILES[@]}"; do
        if [[ -e "$file" || -L "$file" ]]; then
            found+=("$file")
        fi
    done
    echo "${found[@]}"
}

# Backup file before removal
backup() {
    local file="$1"
    if $DRY_RUN; then
        echo "[dry-run] Would backup: $file -> $BACKUP_DIR/"
    else
        mkdir -p "$BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
        echo "Backed up: $file -> $BACKUP_DIR/"
    fi
}

# Remove file (with optional backup)
remove_file() {
    local file="$1"

    if $DRY_RUN; then
        if ! $NO_BACKUP; then
            echo "[dry-run] Would backup: $file"
        fi
        echo "[dry-run] Would remove: $file"
    else
        if ! $NO_BACKUP; then
            backup "$file"
            echo "Removed: $file (backed up)"
        else
            rm -rf "$file"
            echo "Removed: $file"
        fi
    fi
}

# Find existing deprecated files
existing=($(find_existing))

if [[ ${#existing[@]} -eq 0 ]]; then
    echo "No deprecated files found. Nothing to clean up."
    exit 0
fi

echo "Found ${#existing[@]} deprecated file(s):"
for file in "${existing[@]}"; do
    echo "  $file"
done
echo ""

# Confirm before proceeding
if ! $FORCE && ! $DRY_RUN; then
    read -p "Remove these files? (y/n) " -n 1
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

if $DRY_RUN; then
    echo "=== Dry run mode ==="
    echo ""
fi

# Remove deprecated files
for file in "${existing[@]}"; do
    remove_file "$file"
done

echo ""
echo "Done!"
