F_CPU = 12000000
DEVICE = atmega328p
PROGRAMMER = -c usbasp

all: build/blink.hex build/blink.lss
build/blink.elf: build/blink.o | build
build/blink.o: blink.c | build

CC = avr-gcc -mmcu=$(DEVICE)
OC = avr-objcopy
OD = avr-objdump
SZ = avr-size --mcu=$(DEVICE)
UP = avrdude $(PROGRAMMER) -p $(DEVICE)

CFLAGS = -Wall -gdwarf-2 -O3 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -DF_CPU=$(F_CPU)
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

build:
	mkdir -p $@

flash: build/blink.hex
	$(UP) -U "flash:w:$<:i"

clean:
	rm -fR build
