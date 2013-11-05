ifndef SERIAL
	export SERIAL=/dev/ttyACM0
endif

erasedevice:
	read a #press reset on the device, then immediately press enter
	sudo st-flash erase

writebootloader:
	read a #press enter to write bootloader.bin to the device
	sudo st-flash write bootloader.bin 0x08000000

docompile:
	cat *.coffee | coffee -sc > compiled.js

writecompiled:
	cat ${SERIAL}
	echo 'echo(0)' > ${SERIAL}
	cat compiled.js > ${SERIAL}
	echo 'echo(1)' > ${SERIAL}

writesave:
	echo 'save()' > ${SERIAL}
	cat ${SERIAL}
	sleep 1
	cat ${SERIAL}
	sleep 1
	cat ${SERIAL}

clearserial:
	cat ${SERIAL}

dowrite: writecompiled writesave

doopenserial:
	miniterm.py /dev/ttyACM0

allnosave: docompile writecompiled

all: docompile dowrite

default: all

.DEFAULT_GOAL=default