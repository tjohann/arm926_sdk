#
# my simple makefile as something like a user interface
#
ifeq "${ARMEL_HOME}" ""
    $(error error: please source armel_env first!)
endif

MODULES = images pics schematics configs etc
MODULES += arietta imx233
MODULES += include lib lib_target
MODULES += Documentation man
MODULES += kernel src templates
MODULES += projects
MODULES += scripts

DOCS = Documentation

all:: 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|                  Nothing to build                        |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	@echo "| Example:                                                 |"
	@echo "| make get_external_repos -> get external repos like linux,|"
	@echo "|                            xenomai or uboot ...          |"
	@echo "| make get_toolchain      -> install toolchain             |"
	@echo "| make get_latest_kernel  -> download latest kernel version|"
	@echo "| make get_image_tarballs -> download image tarballs       |"
	@echo "| make get_all            -> get all of the above          |"
	@echo "| make clean              -> clean all dir/subdirs         |"
	@echo "| make distclean          -> complete cleanup              |"
	@echo "+----------------------------------------------------------+"	

clean::
	rm -f *~ .*~
	for dir in $(MODULES); do (cd $$dir && $(MAKE) $@); done

distclean: clean
	rm -rf toolchain
	rm -f toolchain_x86_64.tgz
	rm -rf host
	rm -f host_x86_64.tgz

#
# run all get actions in sequence
#
get_all:: get_toolchain get_image_tarballs get_external_repos get_latest_kernel 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|               All 'get' actions complete                 |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"

#
# clone some useful repos (see ./external/README)
#
get_external_repos:: 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|               Clone useful external repos                |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	($(ARMEL_HOME)/scripts/get_external_git_repos.sh -p "git")


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
	($(ARMEL_HOME)/scripts/get_latest_linux_kernel.sh)


#
# download toolchain version as tarball and install it to $ARMEL_HOME
#
get_toolchain: distclean 
	@echo "+----------------------------------------------------------+"
	@echo "|                                                          |"
	@echo "|        Download latest supported toolchain version       |"
	@echo "|                                                          |"
	@echo "+----------------------------------------------------------+"
	($(ARMEL_HOME)/scripts/get_toolchain.sh)


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

