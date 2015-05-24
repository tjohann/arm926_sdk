#
# my simple makefile as something like a user interface
#

MODULES = configs etc images pics common schematics
MODULES += include include scripts 
MODULES += docs
MODULES += kernel src tools templates 

DOCS = docs

all:: 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|                  Nothing to build :-)                    |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	@echo "| Example:                                                 |"
	@echo "| make get_external_repos -> get external repos like linux,|"
	@echo "|                            xenomai or uboot ...          |"
	@echo "| make get_toolchain      -> install toolchain             |"
	@echo "| make get_latest_kernel  -> download latest kernel version|"
	@echo "| make docs               -> create html and/or pdf docs   |"
	@echo "|                            see docs/html and docs/pdf    |"
	@echo "| make clean              -> clean all dir/subdirs         |"
	@echo "| make distclean          -> complete cleanup              |"
	@echo "+----------------------------------------------------------+"	

clean::
	rm -f *~ .*~
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean
	rm -rf v?
	rm -f v?*.tgz

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

#
# download toolchain version as tarball and install it to $ARMEL_HOME
#
get_toolchain: distclean 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|        Download latest supported toolchain version       |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	($(ARMEL_HOME)/bin/get_toolchain.sh)

#
# create html and/or pdf docs under $ARMEL_HOME/docs/html and/or $ARMEL_HOME/docs/pdf
#
docs: 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|        Create html and/or pdf docs -> see ./docs/...     |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	for dir in $(DOCS); do (cd $$dir && $(MAKE) $@); done

