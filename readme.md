This is an espruino coffeescript demo.
===

This demo toggles on an off all the leds independently, based on a random seed.

Tested on the STM32F3DISCOVERY, a ~ $10 development board capable of running espruino.

To compile the app, upload it, and save it run:

    make

To comile the app, and upload it, but not save it, run:

    make allnosave

Bootloader erasing and writing commands are available in the Makefile, so poke around.

All of the compiling, uploading, and saving are done when the usb cable is plugged into the "USB USER" port. All of the bootloader commands required the cable to be plugged into the "USB ST-LINK" port.

Happy coding!
