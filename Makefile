SRC    = sim.c debug.c
TARGET = sim.js

CC = emcc
CFLAGS = -Wall -Wextra -O3 -std=gnu99 -g $(EMCCFLAGS)
ifneq ($(CC), emcc)
    TARGET := $(basename $(TARGET))
else
    EMCCFLAGS = --embed-file xv6.img
endif
LDLIBS = -lm

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(SRC) $(LDLIBS) -o $(TARGET)

PHONY: clean
clean:
	rm -f $(TARGET) $(TARGET).mem *.out *.out.s

