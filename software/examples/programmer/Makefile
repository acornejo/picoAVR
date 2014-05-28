F_CPU = 12000000
DEVICE = atmega328p
PROGRAMMER = -c usbasp

all: main.hex main.lss

CC = avr-gcc
OC = avr-objcopy
OD = avr-objdump
SZ = avr-size --mcu=$(DEVICE)
UP = avrdude $(PROGRAMMER) -p $(DEVICE)

CFLAGS = -Wall -Os -I. -mmcu=$(DEVICE) -DF_CPU=$(F_CPU)

OBJECTS = usbdrv.o usbdrvasm.o isp.o clock.o tpi.o main.o

usbdrv.o: ../../usbdrv/usbdrv.c $(DEPENDS)
	$(CC) $(CFLAGS) -c $< -o $@

usbdrvasm.o: ../../usbdrv/usbdrvasm.S $(DEPENDS)
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.S.o:
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@

main.elf: $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS)

%.lss: %.elf
	$(OD) -d -S $< > $@

%.hex: %.elf
	$(OC) -O ihex -j .text -j .data $< $@
	$(SZ) $<

flash: main.hex
	$(UP) -U flash:w:main.hex:i

clean:
	rm -f main.elf main.hex main.lss $(OBJECTS)
