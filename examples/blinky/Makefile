F_CPU = 12000000
DEVICE = atmega328p
PROGRAMMER = -c usbasp

.PHONY: blink
all: blink
blink: build/blink.elf build/blink.hex build/blink.lss

CC = avr-gcc
OC = avr-objcopy
OD = avr-objdump
SZ = avr-size --mcu=$(DEVICE)
UP = avrdude $(PROGRAMMER) -p $(DEVICE)

CFLAGS = -Wall -gdwarf-2 -O3 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -mmcu=$(DEVICE) -DF_CPU=$(F_CPU)

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

build:
	mkdir -p $@

build/blink.elf: blink.c | build
	$(CC) $(CFLAGS) -o $@ $< 

flash: build/blink.hex
	$(UP) -U "flash:w:build/blink.hex:i"

clean:
	rm -fR build
