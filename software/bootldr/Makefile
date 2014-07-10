F_CPU = 12000000
DEVICE = atmega328p
PROGRAMMER = -c usbasp
# PROGRAMMER = -P /dev/tty.usbmodem00063471 -c avrisp2

VPATH = ../usbdrv

all: build/main.hex build/main.lss
build/main.elf: build/main.o build/usbdrv.o build/usbdrvasm.o
build/main.o: main.c | build
build/usbdrv.o: usbdrv.c | build
build/usbdrvasm.o: usbdrvasm.S | build

CC = avr-gcc -mmcu=$(DEVICE)
OC = avr-objcopy
OD = avr-objdump
SZ = avr-size --mcu=$(DEVICE)
UP = avrdude $(PROGRAMMER) -p $(DEVICE)

include buildparams.inc

CFLAGS = -Wall -Os -g3 -ggdb -fno-move-loop-invariants -fno-tree-scev-cprop -fno-inline-small-functions -I. -DBOOTLOADER_ADDRESS=$(BOOTLOADER_ADDRESS) -DF_CPU=$(F_CPU) $(DEFINES)
LDFLAGS = -Wl,--relax,--gc-sections -Wl,--section-start=.text=$(BOOTLOADER_ADDRESS) -Wl,--defsym=nullVector=0
FLASH = -R .eeprom -R .fuse -R .lock -R .signature
EEPROM = -j .eeprom --set-section-flags=.eeprom="alloc,load" --change-section-lma .eeprom=0  

%.lss: %.elf
	$(OD) -d -S $< > $@

%.hex: %.elf
	$(OC) -O ihex $(FLASH) $< $@
	$(SZ) $<

%.eep: %.elf
	$(OC) -O ihex $(EEPROM) $< $@

%.bin: %.elf
	$(OC) -O binary $(FLASH) $< $@ 

%.elf: %.o
	$(CC) $(LDFLAGS) -o $@ $^

build/%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $^

build/%.o: %.S
	$(CC) $(CFLAGS) -x assembler-with-cpp -o $@ -c $^

build:
	mkdir -p $@

flash: build/main.hex
	$(UP) -U flash:w:$<:i

readflash:
	$(UP) -U flash:r:read.hex:i

fuses:
	$(UP) $(FUSEOPT)

readfuses:
	$(UP) -U lfuse:r:-:m -U hfuse:r:-:m -U efuse:r:-:m

clean: 
	rm -fR build
