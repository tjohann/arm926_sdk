#
# ${ARMEL_HOME}/external/makefile
#

ifeq "${ARMEL_HOME}" ""
    $(error error: please source armel_env first!)
endif


MODULES = $(shell ls -d */ | cut -f1 -d'/' | grep -v xenomai-3 | grep -v void-packages)
MODULES_TO_UPDATE = $(shell ls -d */ | cut -f1 -d'/')

.PHONY: all
all:
	@echo Cheers

.PHONY: clean
clean:
	rm -f *~ *.o .*~
	for dir in $(MODULES); do (cd $$dir/ && $(MAKE) $@); done

distclean: clean

#
# update all cloned repos
#
.PHONY: update_all
update_all:
	rm -f *~ *.o
	for dir in $(MODULES_TO_UPDATE); do (cd $$dir && git pull); done

#
# clone a single external repo (on the device)
#
get_at91bootstrap::
	($(ARMEL_HOME)/scripts/get_external_git_repos.sh -r "at91bootstrap" -p "http")

get_ipipe::
	($(ARMEL_HOME)/scripts/get_external_git_repos.sh -r "ipipe" -p "http")

get_xenomai::
	($(ARMEL_HOME)/scripts/get_external_git_repos.sh -r "xenomai" -p "http")

get_mydriver::
	($(ARMEL_HOME)/scripts/get_external_git_repos.sh -r "mydriver" -p "http")

get_can-utils::
	($(ARMEL_HOME)/scripts/get_external_git_repos.sh -r "can-utils" -p "http")

get_led-dot-clock::
	($(ARMEL_HOME)/scripts/get_external_git_repos.sh -r "clock" -p "https")

get_void-packages::
	($(ARMEL_HOME)/scripts/get_external_git_repos.sh -r "void-packages" -p "https")

