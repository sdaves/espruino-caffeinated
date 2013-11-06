This is a collection of espruino coffeescript demos.
===

Tested on the STM32F3DISCOVERY, a ~ $10 development board capable of running espruino.

To compile the app, upload it, and save it, from within the app folder, run:

    make

To comile the app, and upload it, but not save it, from within the app folder, run:

    make allnosave

Bootloader erasing and writing commands are available in the Makefile, so poke around.

All of the compiling, uploading, and saving require that the usb cable is plugged into the "USB USER" port. All of the bootloader commands required that the cable is plugged into the "USB ST-LINK" port.

Happy coding!
