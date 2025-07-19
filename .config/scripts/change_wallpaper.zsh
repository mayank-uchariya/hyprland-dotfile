#!/bin/zsh

# Set your wallpaper folder path
wallpaper_dir="$HOME/Pictures/Wallpapers"

# Get all image files in the folder
wallpapers=($wallpaper_dir/*(.))

# Check if wallpapers are found
if [[ ${#wallpapers[@]} -eq 0 ]]; then
  echo "No wallpapers found in $wallpaper_dir"
  exit 1
fi

# Pick a random one
random_wallpaper="$wallpapers[$((RANDOM % ${#wallpapers[@]} + 1))]"

# Set it using swww
swww img "$random_wallpaper" --transition-type any --transition-angle 30 --transition-step 90

