F_CPU = 12000000
DEVICE = atmega328p
PROGRAMMER = -c usbasp

VPATH = ../../usbdrv

all: build/main.hex build/main.lss
build/main.elf: build/main.o build/usbdrv.o build/usbdrvasm.o build/isp.o build/clock.o build/tpi.o
build/main.o: main.c | build
build/usbdrv.o: usbdrv.c | build
build/usbdrvasm.o: usbdrvasm.S | build
build/isp.o: isp.c | build
build/clock.o: clock.c | build
build/tpi.o: tpi.S | build

CC = avr-gcc -mmcu=$(DEVICE)
OC = avr-objcopy
OD = avr-objdump
SZ = avr-size --mcu=$(DEVICE)
UP = avrdude $(PROGRAMMER) -p $(DEVICE)

CFLAGS = -Wall -Os -I. -DF_CPU=$(F_CPU)
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
	$(UP) -U "flash:w:$<:i"

clean:
	rm -fR build
