# build all libs

LIBS = libservice libnetwork
LIBS += libi2c libspi libcan
LIBS += libadc libpwm
LIBS += libirc libnfc
LIBS += lib25lc256
LIBS += libdcf77
LIBS += libkeys
LIBS += liblcd1602
LIBS += liblm75
LIBS += libmax7219
LIBS += libpcf8574

DAEMONS = lcdd

all::
	for dir in $(LIBS); do (cd $$dir && $(MAKE) $@); done
	for dir in $(DAEMONS); do (cd $$dir && $(MAKE) $@); done

clean::
	rm -f *~ .*~
	for dir in $(LIBS); do (cd $$dir && $(MAKE) $@); done
	for dir in $(DAEMONS); do (cd $$dir && $(MAKE) $@); done

distclean: clean
