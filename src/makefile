# build all libs

MODULES = libi2c libpcf8574 liblcd1602 liblm75 libspi lib25lc256

all:: 
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

clean::
	rm -f *~ .*~
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean
