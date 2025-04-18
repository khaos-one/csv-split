CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -Os -flto -ffunction-sections -fdata-sections
LDFLAGS = # Define LDFLAGS as empty for macOS compatibility
TARGET = csv-split
SRC = src/main.c
INSTALL_SCRIPT = install.sh
UNINSTALL_SCRIPT = uninstall.sh

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)
	strip $(TARGET)
	chmod +x $(TARGET)

clean:
	rm -f $(TARGET)

install: $(TARGET)
	chmod +x $(INSTALL_SCRIPT)
	./$(INSTALL_SCRIPT)

uninstall:
	chmod +x $(UNINSTALL_SCRIPT)
	./$(UNINSTALL_SCRIPT)

.PHONY: all clean install uninstall 