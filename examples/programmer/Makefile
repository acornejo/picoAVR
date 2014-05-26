F_CPU = 12000000
DEVICE = atmega328
DEFINES = #empty
PROGRAMMER = -c usbasp

all: main.hex main.lss

RM=@rm -f
CC=avr-gcc
OBC=avr-objcopy
OBD=avr-objdump
SIZ=avr-size
AVRDUDE=avrdude $(PROGRAMMER) -p $(DEVICE)

CFLAGS = -Wall -Os -I. -mmcu=$(DEVICE) -DF_CPU=$(F_CPU)

OBJECTS = usbdrv.o usbdrvasm.o isp.o clock.o tpi.o main.o

usbdrv.o: ../../usbdrv/usbdrv.c $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -c $<

usbdrvasm.o: ../../usbdrv/usbdrvasm.S $(DEPENDS)
	$(CC) $(CFLAGS) -o $@ -x assembler-with-cpp -c $<

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.S.o:
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@

clean:
	$(RM) main.elf main.hex main.lss $(OBJECTS)

main.elf: $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS)

%.lss: %.elf
	$(OBD) -d -S $< > $@

%.hex: %.elf
	$(OBC) -O ihex -j .text -j .data $< $@
	$(SIZ) --mcu $(DEVICE) main.elf

flash: main.hex
	avrdude -c ${ISP} -p ${TARGET} -P ${PORT} -U flash:w:main.hex
