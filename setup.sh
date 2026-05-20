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

#if [ -d "$DOTFILES_DIR" ]; then
#    echo "DOTFILES directory already exists. Pulling latest changes..."
#    cd "$DOTFILES_DIR"
#    git pull origin main
#else
#    echo "Cloning DOTFILES repository..."
#    git clone "$REPO_URL" "$DOTFILES_DIR"
#fi

#if [ -d "$DOTFILES_DIR" ]; then
#   echo "📂 Updating dotfiles..."
#    cd "$DOTFILES_DIR"
#    git pull origin main
#else
#    echo "📥 Cloning dotfiles..."
#    git clone "$REPO_URL" "$DOTFILES_DIR"
#fi

# 3. Installing Oh My Zsh
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# ---------------------------------------------------------
# Plugins for Zsh
# ---------------------------------------------------------
echo "Plugins for Zsh..."

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "   Downloading zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "   ✅ zsh-autosuggestions already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "   Downloading zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "   ✅ zsh-syntax-highlighting already installed."
fi

# ---------------------------------------------------------
# Powerlevel10k theme for Zsh
# ---------------------------------------------------------
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"

if [ ! -d "$P10K_DIR" ]; then
    echo "Downloading Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    echo "✅ Powerlevel10k already installed."
fi
# 4. Creating symbolic links for configuration files


echo " Creating symbolic links..."

create_symlink() {
    local source_file="$1"
    local target_file="$2"

    
    if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
        echo "Backing up $target_file -> ${target_file}.backup"
        mv "$target_file" "${target_file}.backup"
    fi
    ln -sf "$source_file" "$target_file"
    echo "Symbolic link $target_file installed."
}

# Link our  .zshrc
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

#
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🔄 Changing default shell to Zsh..."
    chsh -s $(which zsh)
fi

echo "setup.sh completed successfully!"
echo "Please restart your terminal to apply the changes."