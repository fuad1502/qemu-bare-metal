CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mcpu=cortex-m3 -mthumb -nostdlib -fno-builtin -ffreestanding
LDFLAGS = -T linker.ld -Wl,--gc-sections

TARGET = firmware
SOURCES = startup.s boot.c main.c
OBJECTS = $(SOURCES:.c=.o)
OBJECTS := $(OBJECTS:.s=.o)

.PHONY: run clean

$(TARGET).elf: $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

%.o: %.s
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

run: $(TARGET).elf
	qemu-system-arm -M mps2-an385 -kernel $(TARGET).elf -nographic

clean:
	rm -f *.o *.elf *.bin

all: $(TARGET).elf
