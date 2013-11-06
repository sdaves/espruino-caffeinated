This is a collection of espruino coffeescript demos.
===

Tested on the STM32F3DISCOVERY, a ~ $10 development board capable of running espruino.

To compile an app, upload it, and save it, from within the app folder, run:

    make

To compile an app, and upload it, but not save it, from within the app folder, run:

    make allnosave

Bootloader erasing and writing commands are available in the Makefile, so poke around.

All of the compiling, uploading, and saving require that the usb cable is plugged into the "USB USER" port. All of the bootloader commands required that the cable is plugged into the "USB ST-LINK" port.

There is currently a bug with espruino under linux. When first pluggin in the board,
if it is connected with the "USB USER" connector, than you must run:

    make clearserial

for the device to boot. This bug does not effect plugging in the device via the
"USB ST-LINK" connector.

Happy coding!
