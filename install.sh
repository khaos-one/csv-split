#!/bin/bash

TARGET=csv-split
INSTALL_DIR="/usr/local/bin"

if [ ! -f "$TARGET" ]; then
    echo "Error: Executable '$TARGET' not found. Please build the project first using 'make'."
    exit 1
fi

if [ ! -w "$INSTALL_DIR" ]; then
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