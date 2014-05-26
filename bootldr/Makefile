F_CPU = 12000000
DEVICE = atmega328p
PROGRAMMER = -c usbasp
BOOTLOADER_ADDRESS = 0x7000
FUSEOPT = -U lfuse:w:0xd7:m -U hfuse:w:0xd0:m -U efuse:w:0x04:m

all: main.hex main.lss

CC = avr-gcc
OC = avr-objcopy
OD = avr-objdump
SZ = avr-size --mcu=$(DEVICE)
UP = avrdude $(PROGRAMMER) -p $(DEVICE)

CFLAGS = -Wall -Os -I. -mmcu=$(DEVICE) -DBOOTLOADER_ADDRESS=$(BOOTLOADER_ADDRESS) -DF_CPU=$(F_CPU)
LDFLAGS = -Wl,--section-start=.text=$(BOOTLOADER_ADDRESS) -Wl,--defsym=nullVector=0

DEPENDS = bootloaderconfig.h usbconfig.h
OBJECTS = main.o usbdrv.o usbdrvasm.o

usbdrv.o: ../usbdrv/usbdrv.c $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -c $<

usbdrvasm.o: ../usbdrv/usbdrvasm.S $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -x assembler-with-cpp -c $<

main.o: main.c $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -c $<

main.elf: $(OBJECTS) $(DEPENDS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJECTS)

%.lss: %.elf
	$(OD) -d -S $< > $@

%.hex: %.elf
	$(OC) -O ihex -j .text -j .data $< $@
	$(SZ) $<

flash:	main.hex
	$(UP) -U flash:w:main.hex:i

readflash:
	$(UP) -U flash:r:read.hex:i

fuses:
	$(UP) $(FUSEOPT)

readfuses:
	$(UP) -U lfuse:r:-:m -U hfuse:r:-:m -U efuse:r:-:m

clean: 
	rm -f main.hex main.lss main.elf $(OBJECTS)
