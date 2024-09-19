# bash

# Directory containing the images
IMAGE_DIR="$HOME/.config/variety/Downloaded"

change_background() {
    # Find a random image file from the directory (including subdirectories)
    RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

    # Set the background using feh
    feh --bg-fill "$RANDOM_IMAGE"
}

if [ "$1" == "now" ]; then
    change_background
else
    while true; do
        change_background
        # Wait for 5 minutes
        sleep 300
    done
fi