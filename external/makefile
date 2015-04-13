# only for cleaning :-)

MODULES = at91bootstrap
MODULES_TO_UPDATE = $(shell ls -d */ | cut -f1 -d'/')

.PHONY: all
all: 
	@echo Cheers

.PHONY: clean
clean:
	rm -f *~ *.o .*~
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean

#
# update all cloned repos
#
.PHONY: update_all
update_all:
	rm -f *~ *.o
	for dir in $(MODULES_TO_UPDATE); do (cd $$dir && git pull); done
