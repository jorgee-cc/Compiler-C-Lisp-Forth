CC ?= cc
BISON ?= bison
CFLAGS ?= -Wall -Wextra -O2

BUILD_DIR := build
TRAD_SOURCE := $(BUILD_DIR)/trad.tab.c
BACK_SOURCE := $(BUILD_DIR)/back.tab.c

.PHONY: all test clean

all: trad back

trad: $(TRAD_SOURCE)
	$(CC) $(CFLAGS) $< -o $@

back: $(BACK_SOURCE)
	$(CC) $(CFLAGS) $< -o $@

$(BUILD_DIR):
	mkdir -p $@

$(TRAD_SOURCE): trad.y | $(BUILD_DIR)
	$(BISON) -d -o $@ $<

$(BACK_SOURCE): back.y | $(BUILD_DIR)
	$(BISON) -d -o $@ $<

test: all
	./run_tests.sh

clean:
	rm -rf $(BUILD_DIR) trad back
