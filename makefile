# only for cleaning

MODULES = configs docs etc images kernel src pics bin external common

all:: 
	@echo Cheers

clean::
	rm -f *~ .*~
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean
