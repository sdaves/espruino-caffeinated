ifndef SERIAL
	export SERIAL=/dev/ttyACM0
endif

erasedevice:
	read a #press reset on the device, then immediately press enter
	sudo st-flash erase

writebootloader:
	read a #press enter to write bootloader.bin to the device
	sudo st-flash write bootloader.bin 0x08000000

cleanbootloader: erasedevice writebootloader

docompile:
	cat *.coffee | coffee -sc > compiled.js

writecompiled:
	cat ${SERIAL}
	echo 'reset()' > ${SERIAL}
	echo 'echo(0)' > ${SERIAL}
	cat compiled.js > ${SERIAL}
	echo 'echo(1)' > ${SERIAL}

writesave:
	echo 'save()' > ${SERIAL}
	cat ${SERIAL}
	sleep 1
	cat ${SERIAL}
	cat ${SERIAL}
	cat ${SERIAL}
	sleep 1
	cat ${SERIAL}
	cat ${SERIAL}
	cat ${SERIAL}
	sleep 1
	cat ${SERIAL}
	cat ${SERIAL}
	cat ${SERIAL}

clearserial:
	cat ${SERIAL}
	cat ${SERIAL}
	cat ${SERIAL}

dowrite: writecompiled writesave

openserial:
	miniterm.py ${SERIAL}

allnosave: clearserial checknotroot docompile writecompiled

all: clearserial checknotroot docompile dowrite

default: all

checknotroot:
ifeq (,$(wildcard bootloader))
else
	Ran from root, stopped.
endif

ifeq (,$(wildcard bootloader.md))
else
	Ran from bootloader folder, stopped.
endif

.DEFAULT_GOAL=default

