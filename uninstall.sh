#!/bin/bash

TARGET=csv-split
INSTALL_DIR="/usr/local/bin"
INSTALL_PATH="$INSTALL_DIR/$TARGET"

# Check if the file exists in the installation directory
if [ ! -f "$INSTALL_PATH" ]; then
    echo "Info: '$TARGET' not found in '$INSTALL_DIR'. Already uninstalled or never installed?"
    # Optionally, search other common bin directories if desired
    exit 0
fi

# Check for write permissions in the installation directory to remove the file
if [ ! -w "$INSTALL_DIR" ]; then
    # Try using sudo if no write permissions
    echo "Warning: No write permissions for '$INSTALL_DIR'. Attempting uninstallation with sudo."
    if sudo rm "$INSTALL_PATH"; then
        echo "Uninstallation of $TARGET from $INSTALL_DIR succeeded with sudo."
        exit 0
    else
        echo "Error: Uninstallation failed even with sudo. Please check permissions for '$INSTALL_DIR' or remove the file manually: sudo rm $INSTALL_PATH"
        exit 1
    fi
else
    # Uninstall directly if write permissions exist
    echo "Uninstalling $TARGET from $INSTALL_DIR..."
    if rm "$INSTALL_PATH"; then
        echo "Uninstallation of $TARGET succeeded."
    else
        echo "Error during uninstallation of $TARGET from $INSTALL_DIR."
        exit 1
    fi
fi

exit 0 