[PicoAVR](http://acornejo.github.io/picoAVR) is an open source project
that aims to develop a minimalistic but fully functional AVR development
board.

User programs can be uploaded to the PicoAVR using a standard MicroUSB
connector (the same used by android phones). PicoAVR uses
[V-USB](http://www.obdev.at/products/vusb/index.html) and when connected
to your computer can be programmed to
emulate a keyboard, mouse or any other HID device.

The PicoAVR board is similar in capabilities to the Arduino UNO, Arduino
Micro or the Arduino Leonardo, but by using an atmega328p and V-USB
instead of an FTDI chip or an atmega328u4 the cost of the PicoAVR is
significantly decreased.

Since PicoAVR uses the standard usbasp protocol for programming, the
arduino IDE can be used as a complete development environment for
PicoAVR; however usage of arduino is strictly optional, and in no way
required to develop with the PicoAVR.

In its default configuration the PicoAVR operates at 3.3V and runs at
12Mhz, although other configurations are possible.


## PicoAVR is useful if...

* You want to get started with AVR microcontrollers, but don't want to
spend 25$ on an Arduino UNO or an Arduino Micro.
* You want an AVR development board which can also act as an ICSP
programmer.
* You want to create a board of your own using an AVR microcontroller
and you are looking for a simple reference design.
* You are already developing hardware projects using an Arduino, and you
would like to build your own hardware.

## Build Your Own

The cost of the components required for building a single PicoAVR is
less than 10$.

Moreover, keep in mind that due to the economy of scale, building one PicoAVR
is significantly more expensive than building 100 or 1000 boards.

This is ignoring the cost of the equipment required (a soldering station
and an ICSP programmer to burn the bootloader, more on that below).

### BOM

|Part  | Description               | Package      | DigiKey Part #       | Price ($) |
|------|---------------------------|--------------|----------------------|-----------|
|C1,C2 | 4.7uF Capacitor           | 402          | 1276-1056-1-ND       | 0.23 x 2  |
|C3,C4 | 22pF  Capacitor           | 402          | 1276-1681-1-ND       | 0.1 x 2   |
|C5,C6 | 0.1uF Capacitor           | 402          | 1276-1443-1-ND       | 0.1 x 2   |
|R1,R2 | 68 Ohm Resistor           | 402          | RMCF0402JT68R0CT-ND  | 0.02 x 2  |
|R3    | 1.5k Ohm Resistor         | 402          | RMCF0402JT1K50CT-ND  | 0.02 x 1  |
|R5    | 10k Ohm Resistor          | 402          | RMCF0402JT10K0CT-ND  | 0.02 x 1  |
|R6    | 220 Ohm Resistor          | 402          | RMCF0402JT220RCT-ND  | 0.02 x 1  |
|Q1    | 12 Mhz Crystal            | 3.2 x 2.5mm  | 887-2355-1-ND        | 0.71 x 1  |
|U1    | Atmega328p                | TQFP-32      | ATMEGA328P-AU-ND     | 3.61 x 1  |
|IC1   | MCP1700 Voltage Regulator | SOT23        | MCP1700T3302ETTCT-ND | 0.44 x 1  |
|X1    | MicroUSB Connector        | USB-MICRO    | 609-4613-1-ND        | 0.46 x 1  |
|SW1   | Tactile Switch            | 3mm x 4mm    | CKN10502CT-ND        | 0.28 x 1  |

The total comes to 6.5$ per board, although the price goes down if you
want to build more boards.

### PCB

You can get 3 PCB's from [oshpark.com](http://oshpark.com) for only 5$
including shipping. That is less than 2$ per PicoAVR board!

The eagle board files are available in the
[repository](https://github.com/acornejo/picoAVR/tree/master/hardware).

Below is a rendering of the top and bottom of the PCB.

![TopBoard](images/board_top_render.png "Top View PCB")
![BottomBoard](images/board_bottom_render.png "Bottom View PCB")

### Burning the Bootloader
To get the PicoAVR usbasp-based bootloader into the AVR chip, you will
need either: an ICSP programmer, another functioning PicoAVR, or an
arduino.

The PicoAVR provides a standard 6-pin
ICSP connector that can be used to either burn the bootloader into the
board (by closing the self-program jumper), or to act as an ICSP
programmer to reprogram any other AVR development board with an ICSP
connected (including an arduino).

## License

[MIT License](http://opensource.org/licenses/MIT)

<div class="github-fork-ribbon-wrapper right fixed" style="width: 150px;height: 150px;position: fixed;overflow: hidden;top: 0;z-index: 9999;pointer-events: none;right: 0;"><div class="github-fork-ribbon" style="position: absolute;padding: 2px 0;background-color: #333;background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.15));-webkit-box-shadow: 0 2px 3px 0 rgba(0, 0, 0, 0.5);-moz-box-shadow: 0 2px 3px 0 rgba(0, 0, 0, 0.5);box-shadow: 0 2px 3px 0 rgba(0, 0, 0, 0.5);z-index: 9999;pointer-events: auto;top: 42px;right: -43px;-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);-ms-transform: rotate(45deg);-o-transform: rotate(45deg);transform: rotate(45deg);"><a href="https://github.com/acornejo/picoAVR" style="font: 700 13px &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;color: #fff;text-decoration: none;text-shadow: 0 -1px rgba(0, 0, 0, 0.5);text-align: center;width: 200px;line-height: 20px;display: inline-block;padding: 2px 0;border-width: 1px 0;border-style: dotted;border-color: rgba(255, 255, 255, 0.7);">Fork me on GitHub</a></div></div>
