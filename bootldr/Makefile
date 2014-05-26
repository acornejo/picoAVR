F_CPU = 12000000
DEVICE = atmega328
DEFINES = #empty
PROGRAMMER = -c usbasp
BOOTLOADER_ADDRESS = 0x7000
FUSEOPT            = -U lfuse:w:0xd7:m -U hfuse:w:0xd0:m -U efuse:w:0x04:m

RM=@rm -f
CC=avr-gcc
OBC=avr-objcopy
OBD=avr-objdump
SIZ=avr-size
AVRDUDE=avrdude $(PROGRAMMER) -p $(DEVICE)


CFLAGS = -Wall -Os -I. -mmcu=$(DEVICE) -DBOOTLOADER_ADDRESS=$(BOOTLOADER_ADDRESS) -DF_CPU=$(F_CPU) $(DEFINES)
LDFLAGS = -Wl,--section-start=.text=$(BOOTLOADER_ADDRESS) -Wl,--defsym=nullVector=0

DEPENDS =  bootloaderconfig.h
OBJECTS = main.o usbdrv.o usbdrvasm.o

# symbolic targets:
all: main.hex main.lss $(DEPENDS)

usbdrv.o: ../usbdrv/usbdrv.c $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -c $<

usbdrvasm.o: ../usbdrv/usbdrvasm.S $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -x assembler-with-cpp -c $<

main.o: main.c $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -c $<

main.elf: $(OBJECTS) $(DEPENDS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJECTS)

%.lss: %.elf
	$(OBD) -d -S $< > $@

%.hex: %.elf
	$(OBC) -O ihex -j .text -j .data $< $@
	$(SIZ) --mcu $(DEVICE) main.elf

flash:	main.hex
	$(AVRDUDE) -U flash:w:main.hex:i

readflash:
	$(AVRDUDE) -U flash:r:read.hex:i

fuses:
	$(AVRDUDE) $(FUSEOPT)

readfuses:
	$(AVRDUDE) -U lfuse:r:-:m -U hfuse:r:-:m -U efuse:r:-:m

clean: 
	$(RM) main.hex main.lss main.elf $(OBJECTS)
