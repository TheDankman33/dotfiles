#!/bin/bash

set -e

echo "Setting up the dotfiles"

echo "Updating system"
sudo apt update && sudo apt upgrade -y

echo "Installing packages"

PACKAGES=(
    "fastfetch"
    "gh"
    "curl"
    "wget"
    "btop"
    "vim"
    "neovim"
    "fzf"
    "eza"
    "build-essential"
    "python3"
    "python3-pip"
    "python3-venv"
)

echo "Installing packages"
sudo apt install -y "${PACKAGES[@]}"

echo "Packages installed"

DOTFILES_DIR="$HOME/dotfiles"

REPO_URL="https://github.com/TheDankman33/dotfiles.git"