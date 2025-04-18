CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -Os
TARGET = csv-split
SRC = src/main.c
INSTALL_SCRIPT = install.sh

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)
	# Strip symbols to reduce size
	strip $(TARGET)
	# Set executable permissions
	chmod +x $(TARGET)

clean:
	rm -f $(TARGET)

install: $(TARGET)
	# Ensure install script is executable
	chmod +x $(INSTALL_SCRIPT)
	# Run the install script (might require sudo)
	./$(INSTALL_SCRIPT)

.PHONY: all clean install 