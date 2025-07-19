#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/personal/new_wallpapers"
MONITOR="eDP-1"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"


#WALLPAPER_DIR="$HOME/personal/new_wallpapers"
#MONITOR="eDP-1"
#WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
#swww img "$WALLPAPER" --transition-type random --transition-angle 30 --transition-step 90 --outputs "$MONITOR"
