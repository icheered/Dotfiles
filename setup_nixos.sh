# #!/usr/bin/env bash

# Get the current directory
current_dir=$(pwd)

# Check if nixos_config folder exists in the current directory
if [ ! -d "$current_dir/nixos_config" ]; then
    echo "Error: nixos_config folder not found in the current directory."
    exit 1
fi

# Check if /etc/nixos directory exists
if [ ! -d "/etc/nixos" ]; then
    echo "Error: /etc/nixos directory not found. Make sure you're running this on a NixOS system."
    exit 1
fi

# Create the symlink
sudo ln -s "$current_dir/nixos_config" "/etc/nixos/nixos_config"

# Check if the symlink was created successfully
if [ $? -eq 0 ]; then
    echo "Symlink created successfully: /etc/nixos/nixos_config -> $current_dir/nixos_config"
else
    echo "Error: Failed to create symlink. Make sure you have the necessary permissions."
    exit 1
fi
