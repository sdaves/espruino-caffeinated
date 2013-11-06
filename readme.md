This is a collection of espruino coffeescript demos.
===

Tested on the STM32F3DISCOVERY, a ~ $10 development board capable of running espruino.

Getting Started
---

To flash the bootloader, plug the usb into the "USB ST-LINK" port, and run:

    cd bootloader
    make cleanbootloader

and flow the instructions.

All other communication requires the usb to be plugged into the "USB USER" port.

To compile an app, upload it, and save it to the device, from an app folder, run:

    make

To compile an app, upload it, but not save it to the device, from an app folder, run:

    make allnosave

Notes
---

There is currently a bug with espruino under linux. When the board is first connected, run:

    make clearserial

for the device to boot. This bug does not effect plugging in the device via the
"USB ST-LINK" connector for bootloader flashing.

Happy hacking!
