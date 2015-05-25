# only for cleaning 

MODULES = $(shell ls -d */ | cut -f1 -d'/')
DOCS = doc_arm926sdk

all:: 
	@echo Cheers

clean::
	rm -f *~
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean

docs::
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|                      Build docs                          |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	for dir in $(DOCS); do (cd $$dir && $(MAKE) $@); done

man::
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|                  Install man pages                       |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
