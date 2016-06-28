#
# makefile
#

#MODULES = $(shell ls -d */ | cut -f1 -d'/')

ifeq "${ARMEL_HOME}" ""
    $(error error: please source armel_env first!)
endif


.PHONY: all
all:
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|                  Nothing to build                        |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	@echo "| make get_image_tarballs -> download image tarballs       |"
	@echo "| make clean              -> clean all dir/subdirs         |"
	@echo "+----------------------------------------------------------+"

.PHONY: clean
clean:
	rm -f *~ *.o .*~
#	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean

#
# download image tarballs to $ARMEL_HOME/images
#
get_image_tarballs:
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|        Download latest supported image tarballs          |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	($(ARMEL_HOME)/scripts/get_image_tarballs.sh)
