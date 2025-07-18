#!/bin/zsh

# Set your wallpaper folder path
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Get all wallpapers with 'jjk' in the name (case-insensitive)
wallpapers=($(find "$WALLPAPER_DIR" -type f \( -iname '*jjk*.jpg' -o -iname '*jjk*.png' -o -iname '*jjk*.jpeg' \)))

# Check if we found any matching wallpapers
if [[ ${#wallpapers[@]} -eq 0 ]]; then
  echo "No matching wallpapers found with 'jjk' in the name."
  exit 1
fi

# Choose a random wallpaper from the filtered list
random_wallpaper="$wallpapers[$((RANDOM % ${#wallpapers[@]} + 1))]"

# Set the wallpaper using swww with transition
swww img "$random_wallpaper" --transition-type random --transition-angle 30 --transition-step 90

