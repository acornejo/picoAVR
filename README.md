# [PicoAVR](http://acornejo.github.io/picoAVR)

[PicoAVR](http://acornejo.github.io/picoAVR) is an open source AVR
development board which aims to a minimalistic but fully functional
alternative to Arduino.
The PicoAVR board measures less than 1 square inch, and for less than 10$ you can buy all the components to build your own.

![Blinky](http://acornejo.github.io/picoAVR/images/photo.jpg "Blinky on PicoAVR")

The PicoAVR can be powered and programmed through a standard MicroUSB
connector, the same connector used by android phones and tablets.
PicoAVR uses the [V-USB](http://www.obdev.at/products/vusb/index.html)
software implementation of the USB stack, and when connected to your
computer can easily be programmed to emulate a keyboard,
mouse or any other HID device.

The PicoAVR board is similar in capabilities to the [Arduino
UNO](http://arduino.cc/en/Main/ArduinoBoardUno), [Arduino
Micro](http://arduino.cc/en/Main/arduinoBoardMicro) or the [Arduino
Leonardo](http://arduino.cc/en/Main/arduinoBoardLeonardo), but by using
an atmega328p and V-USB instead of an FTDI chip or an atmega328u4 the
number of components and the cost of the PicoAVR is significantly
reduced.

Since PicoAVR uses the same
[protocol](http://www.obdev.at/products/vusb/usbasploader.html) as the
[usbasp](www.fischl.de/usbasp/) for programming, it is supported by
the latest versions of avrdude. As a result both 
Atmel Studio 6 or the Arduino Software can be used as complete
development environments for the PicoAVR. However, you are not
constrained to these, and you can easily develop for the PicoAVR using
avr-gcc, avrdude and the editor of your choice.

In its default configuration the PicoAVR runs at 12 Mhz and operates at
3.3 V, which makes it easy to interface to the newer 3.3 V devices without
requiring a level shifter.


## PicoAVR may be interesting to you if...

* You are already developing hardware projects using an Arduino, but you
would prefer to build your own hardware.
* You want to get started with AVR microcontrollers, but don't want to
spend 25$ on an Arduino UNO or an Arduino Micro.
* You want an AVR development board which has a standard 6-pin ICSP
connector and can be used as an ICSP programmer for other
microcontrollers.
* You want to create a board of your own using an AVR microcontroller
and you are looking for a simple reference design.

## Build Your Own

You can buy the components to build your own for less than 10$ per board.

Moreover, keep in mind that due to economies of scale, building 100 or
1000 PicoAVR's is significantly cheaper per unit than building a single
board.

The only equipment required to build your own PicoAVR is a soldering
iron and an ICSP programmer to flash the bootloader (more on that below).

### BOM

|Part  | Description               | Package      | DigiKey Part #       | Price ($) |
|------|---------------------------|--------------|----------------------|-----------|
|C1,C2 | 4.7uF Capacitor           | 402          | 1276-1056-1-ND       | 0.23 x 2  |
|C3,C4 | 22pF  Capacitor           | 402          | 1276-1681-1-ND       | 0.1 x 2   |
|C5,C6 | 0.1uF Capacitor           | 402          | 1276-1443-1-ND       | 0.1 x 2   |
|R1,R2 | 68 Ohm Resistor           | 402          | RMCF0402JT68R0CT-ND  | 0.02 x 2  |
|R3    | 1.5k Ohm Resistor         | 402          | RMCF0402JT1K50CT-ND  | 0.02 x 1  |
|R4    | 10k Ohm Resistor          | 402          | RMCF0402JT10K0CT-ND  | 0.02 x 1  |
|R5    | 220 Ohm Resistor          | 402          | RMCF0402JT220RCT-ND  | 0.02 x 1  |
|Q1    | 12 Mhz Crystal            | 3.2 x 2.5mm  | 887-2355-1-ND        | 0.71 x 1  |
|U1    | Atmega328p                | TQFP-32      | ATMEGA328P-AU-ND     | 3.61 x 1  |
|IC1   | MCP1700 Voltage Regulator | SOT23        | MCP1700T3302ETTCT-ND | 0.44 x 1  |
|X1    | MicroUSB Connector        | USB-MICRO    | 609-4613-1-ND        | 0.46 x 1  |
|SW1   | Tactile Switch            | 3mm x 4mm    | CKN10502CT-ND        | 0.28 x 1  |

The total comes to less than 6.5$ per board. Digikey offers educational and
bulk discounts.

### PCB

You can get 3 PCB's from [oshpark.com](https://oshpark.com/shared_projects/4zQfKzvO) for only 4.95$
including shipping. That is less than 2$ per PicoAVR board! Click [here](https://oshpark.com/shared_projects/4zQfKzvO) to order your own. 

The eagle board files are available in the
[repository](https://github.com/acornejo/picoAVR/tree/master/hardware).

Below is a rendering of the top and bottom of the PCB.

![TopBoard](http://acornejo.github.io/picoAVR/images/board_top_render.png "Top View PCB")
![BottomBoard](http://acornejo.github.io/picoAVR/images/board_bottom_render.png "Bottom View PCB")

### Flashing the Bootloader
To get the PicoAVR usbasp-based bootloader flashed into the AVR chip you will
need either: a dedicated [ICSP
programmer](http://store.atmel.com/PartDetail.aspx?q=p:10500054#tc:description),
an [Arduino](http://arduino.cc/en/Tutorial/ArduinoISP) and jumper
cables, or an already functioning PicoAVR.

The PicoAVR provides a standard 6-pin ICSP connector that can be used to
either flash the bootloader into the board (by closing the self-program
jumper), or to act as an ICSP programmer to reprogram any other
AVR board (including another PicoAVR or an Arduino) using a standard
6-pin ICSP connector.

## License

[MIT License](http://opensource.org/licenses/MIT)
