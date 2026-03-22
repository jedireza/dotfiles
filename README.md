# dotfiles

This is my dotfiles repo. There are many like it, but this one is mine.

## How it works

The `install.sh` script symlinks files from this repo into your home directory. This means your home directory points back here — edits in either place are the same file, and everything stays version-controlled.

```
~/.zshrc       →  dotfiles/.zshrc
~/.vimrc       →  dotfiles/.vimrc
~/.vim/        →  dotfiles/.vim/
~/.config/     →  dotfiles/config/
```

Existing files are backed up to `~/.dotfiles_backup/<timestamp>/` before being replaced.

```sh
# Preview what will change
./install.sh --dry-run

# Install (will prompt for confirmation)
./install.sh

# Install and remove deprecated files from previous setups
./install.sh --cleanup
```

The install also initializes git submodules (oh-my-zsh).

## What's where

| Path | What it configures |
|---|---|
| `.zshrc` | Shell — aliases, PATH, history, tool integrations (nvm, fzf, kubectl) |
| `.vimrc` | Vim — plugins (via vim-plug), keybindings, linting (ALE), theme |
| `.vim/` | Vim runtime — autoload scripts and plugin installs |
| `config/git/config` | Git — user identity, editor, push/merge defaults |
| `config/git/ignore` | Git — global ignore patterns |
| `config/tmux/tmux.conf` | Tmux — keybindings, 256-color, status bar styling |
| `config/gh/` | GitHub CLI (gitignored — contains auth tokens) |
| `config/opencode/` | OpenCode AI plugin |
| `install.sh` | Symlink installer with `--dry-run`, `--force`, `--cleanup` flags |
| `cleanup.sh` | Removes deprecated dotfiles from older versions of this repo |

## Extending

**Shell** — Add aliases, functions, or PATH entries to `.zshrc`. For machine-specific config that shouldn't be committed, create `~/.zshrc.local` — it's sourced automatically and gitignored.

**Vim plugins** — Add `Plug` entries to `.vimrc`, then run `:PlugInstall` inside vim. The `plugged/` directory is gitignored so plugin installs stay local.

**Git** — Edit `config/git/config` for identity, editor, or behavior changes. Add global ignore patterns to `config/git/ignore`.

**Tmux** — Edit `config/tmux/tmux.conf` for keybindings or status bar changes.

**New tools** — Drop config files into `config/<tool>/`. Since `~/.config` is symlinked to `config/`, anything under the XDG config path is already tracked.

## Cleanup

The `cleanup.sh` script removes files from `~/` that older versions of this repo used to install directly (`.bash_profile`, `.gitconfig`, `.tmux.conf`, etc.). These have since moved into `config/` or been consolidated.

```sh
./cleanup.sh --dry-run    # preview
./cleanup.sh              # remove (backs up first)
./cleanup.sh --no-backup  # remove without backup
```

## Originally inspired by

- http://dotfiles.github.io/
- https://github.com/mathiasbynens/dotfiles/
- https://github.com/gf3/dotfiles/
- https://github.com/felixge/dotfiles/
