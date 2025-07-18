#!/bin/zsh

echo "Hello, this is my hyprland installation setup."
echo "Read the following question and answer them throughly."

echo -n "Do you have yay package? - [y/n] : "
read foo

if [ $foo = 'n' ]; then
	sudo pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
else
	echo "Yay is already installed"
fi

echo -n "Do you have hyprland already? - [y/n] : "
read foo

if [ $foo = 'n' ]; then
	yay -S hyprland-git  
else 
	echo 'hyprland is already installed'
fi

echo -n "Do you want to install hyprland useful utility? - [y/n] : "
read foo

if [ $foo = 'y' ]; then
	yay -S waybar mako rofi ghostty nvim hyprpaper hyprpolkitagent dolphin nm-applet swww batsignal
else
	echo 'Useful utility installation denied'
fi

echo -n "Do you want login theme? - [y/n] : "
read foo

if [ $foo = 'y' ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
else
	echo 'login theme not applied'
fi

echo -n "Do you want to copy my config files to apply changes in your system? - [y/n] : "
read foo

if [ $foo = 'y' ]; then
	echo "I will copy your existing files in .config.backup"
	for folder in hypr rofi ghostty nvim mako waybar; do
  		rm -rf ~/.config/$folder
  		cp -r dotfiles/.config/$folder ~/.config/
        done
else
	echo "Config files does not applied"
fi

echo -n "Do you want to reboot your system? - [y/n] : "
read foo

if [ $foo = 'y' ]; then
	reboot
else
	echo "Installation complete"
fi
