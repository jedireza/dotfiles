#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Flags
DRY_RUN=false
FORCE=false
CLEANUP=false

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --dry-run    Preview changes without making them"
    echo "  --force      Skip confirmation prompts"
    echo "  --cleanup    Also remove deprecated files from home directory"
    echo "  -h, --help   Show this help message"
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
        --cleanup)
            CLEANUP=true
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

# Backup existing file or symlink if it exists
backup() {
    local target="$1"
    if [[ -e "$target" || -L "$target" ]]; then
        if $DRY_RUN; then
            echo "[dry-run] Would backup: $target -> $BACKUP_DIR/"
        else
            mkdir -p "$BACKUP_DIR"
            mv "$target" "$BACKUP_DIR/"
            echo "Backed up: $target -> $BACKUP_DIR/"
        fi
    fi
}

# Create symlink, backing up existing file first
link() {
    local src="$1"
    local dest="$2"

    if $DRY_RUN; then
        if [[ -e "$dest" || -L "$dest" ]]; then
            echo "[dry-run] Would backup: $dest"
        fi
        echo "[dry-run] Would link: $dest -> $src"
    else
        backup "$dest"
        ln -s "$src" "$dest"
        echo "Linked: $dest -> $src"
    fi
}

# Confirm before proceeding
if ! $FORCE && ! $DRY_RUN; then
    read -p "This will create symlinks in your home directory. Continue? (y/n) " -n 1
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

echo ""
if $DRY_RUN; then
    echo "=== Dry run mode ==="
    echo ""
fi

# Create symlinks
link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
link "$DOTFILES_DIR/.vim" "$HOME/.vim"
link "$DOTFILES_DIR/config" "$HOME/.config"

# Initialize git submodules
echo ""
if $DRY_RUN; then
    echo "[dry-run] Would initialize git submodules"
else
    echo "Initializing git submodules..."
    cd "$DOTFILES_DIR"
    git submodule init
    git submodule update
fi

# Run cleanup if requested
if $CLEANUP; then
    echo ""
    echo "Running cleanup..."
    cleanup_flags=""
    if $DRY_RUN; then
        cleanup_flags="$cleanup_flags --dry-run"
    fi
    if $FORCE; then
        cleanup_flags="$cleanup_flags --force"
    fi
    "$DOTFILES_DIR/cleanup.sh" $cleanup_flags
fi

echo ""
echo "Done!"
