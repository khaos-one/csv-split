#!/bin/bash

TARGET=csv-split
INSTALL_DIR="/usr/local/bin"

# Check if the executable exists in the current directory
if [ ! -f "$TARGET" ]; then
    echo "Error: Executable '$TARGET' not found. Please build the project first using 'make'."
    exit 1
fi

# Check for write permissions in the installation directory
if [ ! -w "$INSTALL_DIR" ]; then
    # Try using sudo if no write permissions
    echo "Warning: No write permissions for '$INSTALL_DIR'. Attempting installation with sudo."
    if sudo cp "$TARGET" "$INSTALL_DIR/"; then
        echo "Installation of $TARGET to $INSTALL_DIR succeeded with sudo."
        echo "You can now use the utility by calling '$TARGET' in your terminal."
        exit 0
    else
        echo "Error: Installation failed even with sudo. Please check permissions for '$INSTALL_DIR'."
        exit 1
    fi
else
    # Install directly if write permissions exist
    echo "Installing $TARGET to $INSTALL_DIR..."
    if cp "$TARGET" "$INSTALL_DIR/"; then
        echo "Installation of $TARGET succeeded."
        echo "You can now use the utility by calling '$TARGET' in your terminal."
    else
        echo "Error during installation of $TARGET."
        exit 1
    fi
fi

exit 0 