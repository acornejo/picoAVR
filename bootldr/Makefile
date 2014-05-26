F_CPU = 12000000
DEVICE = atmega328
DEFINES = #empty
PROGRAMMER = usbasp
BOOTLOADER_ADDRESS = 0x7000
FUSEOPT            = -U lfuse:w:0xd7:m -U hfuse:w:0xd0:m -U efuse:w:0x04:m

# Tools:

RM=@rm -f

CC=avr-gcc
OBC=avr-objcopy
OBD=avr-objdump
SIZ=avr-size
AVRDUDE=avrdude -c $(PROGRAMMER) -p $(DEVICE)


CFLAGS = -Wall -Os -fno-move-loop-invariants -fno-tree-scev-cprop -fno-inline-small-functions -I. -mmcu=$(DEVICE) -DBOOTLOADER_ADDRESS=$(BOOTLOADER_ADDRESS) -DF_CPU=$(F_CPU) $(DEFINES)
LDFLAGS = -Wl,--relax,--gc-sections -Wl,--section-start=.text=$(BOOTLOADER_ADDRESS) -Wl,--defsym=nullVector=0

DEPENDS =  bootloaderconfig.h

# symbolic targets:
all: main.hex main.lss $(DEPENDS)

usbdrvasm.o: ../usbdrv/usbdrvasm.S $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -x assembler-with-cpp -c $<

oddebug.o: ../usbdrv/oddebug.c $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -c $<

main.o: main.c $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -c $<

# file targets:
main.elf: usbdrvasm.o oddebug.o main.o $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ usbdrvasm.o oddebug.o main.o $(LDFLAGS)

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
	$(RM) main.hex
	$(RM) main.lss
	$(RM) main.elf
	$(RM) main.o
	$(RM) usbdrvasm.o
	$(RM) oddebug.o
