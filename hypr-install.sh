#!/usr/bin/env bash

sudo pacman -S --noconfirm ttf-jetbrains-mono-nf

echo "Hello, this is my hyprland installation setup."
echo "Read the following question and answer them throughly."

validate_yn() {
    local input=$1
    if [[ ! $input =~ ^[YyNn]$ ]]; then
        echo "Invalid input. Please enter y or n."
        exit 1
    fi
}

echo -n "Do you have paru package manager? - [y/n] : "
read foo
validate_yn $foo

if [ "$foo" = 'n' ] || [ "$foo" = 'N' ]; then
    sudo pacman -S --needed git base-devel || { echo "Failed to install dependencies"; exit 1; }
    git clone https://aur.archlinux.org/paru.git || { echo "Failed to clone paru"; exit 1; }
    cd paru || { echo "Failed to enter paru directory"; exit 1; }
    makepkg -si || { echo "Failed to build paru"; exit 1; }
    cd .. && rm -rf paru
else
    echo "Yay is already installed"
fi

echo -n "Do you have hyprland already? - [y/n] : "
read foo
validate_yn $foo

if [ "$foo" = 'n' ] || [ "$foo" = 'N' ]; then
    paru -S hyprland-git || { echo "Failed to install Hyprland"; exit 1; }
else
    echo "hyprland is already installed"
fi

echo -n "Do you want to install zsh and oh-my-zsh? - [y/n] : "
read foo
validate_yn $foo

if [ "$foo" = 'y' ] || [ "$foo" = 'Y' ]; then
    sudo pacman -S --noconfirm --needed zsh || { echo "Failed to install zsh"; exit 1; }
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || { echo "Failed to install oh-my-zsh"; exit 1; }
    echo "zsh and oh-my-zsh installed"
else
    echo "zsh and oh-my-zsh installation skipped"
fi

echo -n "Do you want to install hyprland useful utility? - [y/n] : "
read foo
validate_yn $foo

if [ "$foo" = 'y' ] || [ "$foo" = 'Y' ]; then
    paru -S --noconfirm --needed waybar mako rofi-wayland ghostty neovim hyprpaper hyprpolkitagent dolphin networkmanager swww batsignal || { echo "Failed to install utilities"; exit 1; }
else
    echo "Useful utility installation denied"
fi

echo -n "Do you want login theme? - [y/n] : "
read foo
validate_yn $foo

if [ "$foo" = 'y' ] || [ "$foo" = 'Y' ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)" || { echo "Failed to install login theme"; exit 1; }
else
    echo "login theme not applied"
fi

echo -n "Do you want to copy my config files to apply changes in your system? - [y/n] : "
read foo
validate_yn $foo

if [ "$foo" = 'y' ] || [ "$foo" = 'Y' ]; then
    if [ ! -d "dotfiles/.config" ]; then
        echo "dotfiles/.config not found"
        exit 1
    fi
    echo "I will copy your existing files in .config.backup"
    mkdir -p ~/.config.backup
    for folder in hypr rofi ghostty nvim mako waybar; do
        [ -d ~/.config/$folder ] && mv ~/.config/$folder ~/.config.backup/
        cp -r dotfiles/.config/$folder ~/.config/ || { echo "Failed to copy $folder"; exit 1; }
    done
else
    echo "Config files does not applied"
fi

echo -n "Do you want to reboot your system? - [y/n] : "
read foo
validate_yn $foo

if [ "$foo" = 'y' ] || [ "$foo" = 'Y' ]; then
    sudo systemctl reboot
else
    echo "Installation complete"
fi
