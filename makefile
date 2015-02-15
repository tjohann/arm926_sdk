# only for cleaning

MODULES = configs docs etc images kernel src pics bin

all:: 
	@echo Cheers

clean::
	rm -f *~ .*~
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean
