#!/usr/bin/env bash
set -Eeuo pipefail

CONFIG_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
OMZ_DIR="$CONFIG_DIR/oh-my-zsh"
ZSH_CUSTOM="$OMZ_DIR/custom"

log() {
  printf '[setup] %s\n' "$*"
}

die() {
  printf '[setup] error: %s\n' "$*" >&2
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

install_system_packages() {
  local packages=(git curl zsh tmux neovim emacs)

  if command_exists apt-get; then
    sudo apt-get update
    sudo apt-get install -y "${packages[@]}"
  elif command_exists dnf; then
    sudo dnf install -y "${packages[@]}"
  elif command_exists brew; then
    brew install "${packages[@]}"
  else
    log "No supported package manager found; install these tools manually: ${packages[*]}"
  fi
}

clone_if_missing() {
  local url="$1"
  local destination="$2"

  if [[ -d "$destination" ]]; then
    log "Keeping existing $(basename "$destination")"
    return
  fi

  git clone --depth=1 "$url" "$destination"
}

ensure_zdotdir() {
  local zshenv="$HOME/.zshenv"
  local setting="export ZDOTDIR=\"\$HOME/.config/zsh\""

  touch "$zshenv"
  if ! grep -Fqx "$setting" "$zshenv"; then
    printf '\n%s\n' "$setting" >> "$zshenv"
  fi
}

[[ "$(id -u)" -ne 0 ]] || die "run this script as a regular user, not root"

install_system_packages

clone_if_missing \
  "https://github.com/ohmyzsh/ohmyzsh.git" \
  "$OMZ_DIR"

clone_if_missing \
  "https://github.com/zsh-users/zsh-autosuggestions.git" \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing \
  "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing \
  "https://github.com/MichaelAquilina/zsh-you-should-use.git" \
  "$ZSH_CUSTOM/plugins/you-should-use"
clone_if_missing \
  "https://github.com/fdellwing/zsh-bat.git" \
  "$ZSH_CUSTOM/plugins/zsh-bat"
clone_if_missing \
  "https://github.com/romkatv/powerlevel10k.git" \
  "$ZSH_CUSTOM/themes/powerlevel10k"

ensure_zdotdir

log "Setup complete. Start a new shell, then launch nvim or emacs to install their packages."
