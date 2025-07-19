#!/usr/bin/env bash

# Set your projects base directory
PROJECTS_DIR=~/dev

# Use fzf to pick a project
DIR=$(find "$PROJECTS_DIR" -mindepth 1 -maxdepth 1 -type d | fzf)

# Exit if no directory selected
[ -z "$DIR" ] && echo "No project selected." && exit 1

# Generate a session name from directory name
SESSION=$(basename "$DIR" | tr . _)

# If session doesn't exist, create it
tmux has-session -t "$SESSION" 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s "$SESSION" -c "$DIR"

  # Window 1: shell with clear
  tmux send-keys -t "$SESSION:1" clear C-m

  # Window 2: shell
  tmux new-window -t "$SESSION:2" -c "$DIR"
fi

# Check if already inside a tmux session
if [ -n "$TMUX" ]; then
  # Switch to the target session
  tmux switch-client -t "$SESSION:1"
else
  # Attach to the target session
  tmux attach -t "$SESSION:1"
fi
