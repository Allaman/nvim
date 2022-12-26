#!/bin/bash

# Copyright (C) 2022 Michael Peter <michaeljohannpeter@gmail.com>
# Installing all dependencies for using my Neovim config at https://github.com/Allaman/nvim/

set -e

LINUX_HELP_STRING="################################################################################
- Requires sudo to install some basic packages via your package manager
- Installs brew in /home/linuxbrew (requires sudo as well) see https://docs.brew.sh/Homebrew-on-Linux
- Manages all packages required for Neovim via brew (no sudo required)
- This could result in duplicated tool installations!
- Currently, only Bash ootb is supported
- Modifies your ~/.profile and ~/.bashrc to source paths

Just confirm / hit enter at every choice for the default settings (recommended)

After this script is finished
-  log out or open a new shell
- Open nvim and run :Lazy sync, close nvim
- Open nvim and wait for Mason automatically installing dependencies
Enjoy!

Hit 1 if you agree and want to continue otherwise 2
################################################################################"

OS=""
LINUX_DISTRIBUTION=""


abort () {
  printf "ERROR: %s\n" "$@" >&2
  exit 1
}

log () {
  printf "################################################################################\n"
  printf "%s\n" "$@"
  printf "################################################################################\n"
}

check_prerequisites () {
  if [ -z "${BASH_VERSION:-}" ]; then
    abort "Bash is required to interpret this script."
  fi

  if [[ $EUID -eq 0 ]]; then
    abort "Script must not be run as root user"
  fi

  command -v sudo > /dev/null 2>&1 || { abort "sudo not found - please install"; }

  arch=$(uname -m)
  if [[ $arch =~ "arm" || $arch =~ "aarch64" ]]; then
    abort "Only amd64 is supported"
  fi
}

ask_for_understanding () {
  echo "$1"
  select choice in "Yes" "No"; do
    case $choice in
      Yes ) echo "Going on"; break;;
      No ) exit;;
    esac
  done
}

get_os () {
  if [[ "$OSTYPE" =~ "darwin"* ]]; then
    OS="apple"
  elif [[ "$OSTYPE" =~ "linux" ]]; then
    OS="linux"
    log "Running on Linux"
    ask_for_understanding "$LINUX_HELP_STRING"
  fi
}

get_linux_distribution () {
  local release
  release=$(cat /etc/*-release)
  if [[ "$release" =~ "Debian" ]]; then
    LINUX_DISTRIBUTION="debian"
  elif [[ "$release" =~ "Ubuntu" ]]; then
    LINUX_DISTRIBUTION="ubuntu"
  elif [[ "$release" =~ "Arch" ]]; then
    LINUX_DISTRIBUTION="arch"
  fi
}

install_brew () {
  if ! command -v brew >/dev/null 2>&1; then
    log "Install brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # shellcheck disable=SC2016
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    log "Install gcc (recommended by brew)"
    brew install gcc
  fi
}

install_neovim_dependencies () {
  log "Installing Neovim dependencies"
  brew install \
    fd \
    ripgrep \
    fzf \
    tmux \
    go \
    node \
    python \
    warrensbox/tap/tfswitch
  if ! command -v cargo >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
}

install_neovim_head () {
  if ! command -v nvim >/dev/null 2>&1; then
    log "Installing Neovim HEAD"
    brew install --HEAD neovim
  elif [[ ! $(nvim --version) =~ "dev" ]]; then
    abort "Neovim is installed but not HEAD version"
  else
    log "Skipping Neovim installation"
  fi
}

git_clone_neovim_config () {
  local neovim_config_path="$HOME/.config/nvim"
  log "Cloning Neovim config to $neovim_config_path"
  if [[ -d "$neovim_config_path" ]]; then
    abort "$neovim_config_path already exists"
  fi
  git clone https://github.com/Allaman/nvim.git "$neovim_config_path"
}

main () {
  check_prerequisites
  get_os
  if [[ $OS == "linux" ]]; then
    get_linux_distribution
    local common_packages="git curl gip tar unzip"
    if [[ $LINUX_DISTRIBUTION == "debian" || $LINUX_DISTRIBUTION == "ubuntu" ]]; then
      log "Running on DEB based system"
      sudo apt-get update
      # shellcheck disable=SC2086
      sudo apt-get install build-essential $common_packages
      install_brew
      install_neovim_dependencies
      install_neovim_head
      git_clone_neovim_config
    elif [[ $LINUX_DISTRIBUTION == "arch" ]]; then
      echo running on arch based system
      sudo pacman -Sy
      # shellcheck disable=SC2086
      sudo pacman -S base-devel $common_packages
      install_brew
      install_neovim_dependencies
      install_neovim_head
      git_clone_neovim_config
    fi
  elif [[ $OS == "apple" ]];then
    # TODO:
    echo this is an apple
  fi
}

main
