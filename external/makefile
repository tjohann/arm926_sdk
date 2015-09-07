#
# ${ARMEL_HOME}/external/makefile
#

MODULES = $(shell ls -d */ | cut -f1 -d'/' | grep -v OLINUXINO | grep -v xenomai-3)
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
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "at91bootstrap" -p "http")

get_linux-linus::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "linus" -p "http")

get_rt-tests::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "rt-tests" -p "http")

get_ipipe::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "ipipe" -p "http")

get_xenomai::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "xenomai" -p "http")

get_olimex-docs::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "olimex-docs" -p "http")

get_uboot::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "uboot" -p "http")

get_mydriver::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "mydriver" -p "http")

get_can-utils::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "can-utils" -p "http")

get_libsocketcan::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "libsocketcan" -p "git")

get_sllin::
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -r "sllin" -p "git")
