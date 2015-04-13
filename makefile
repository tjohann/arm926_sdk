# 

MODULES = configs docs etc images kernel src pics bin external common

all:: 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|                  Nothing to build :-)                    |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	@echo "| Example:                                                 |"
	@echo "| make get_external_repos -> get external repos like linux |"
	@echo "| make clean              -> clean all dir/subdirs         |"
	@echo "| make distclean          -> complete cleanup              |"
	@echo "+----------------------------------------------------------+"	

clean::
	rm -f *~ .*~
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean

#
# clone some useful repos (see ./external/README)
#
get_external_repos:: 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|               Clone useful external repos                |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	($(ARMEL_HOME)/bin/get_external_git_repos.sh -p "http")

#
# download latest supported kernel version as tarball and install it to
# ./kernel/linux-$ARMEL_KERNEL_VER
#
get_latest_kernel:: 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|        Download latest supported kernel version          |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	($(ARMEL_HOME)/bin/get_latest_linux_kernel.sh)
