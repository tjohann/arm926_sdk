ARM926_SDK
=========

This is my arm926te sdk for usage with x86_64 or armv7hf host to develop for devices like arietta (see http://www.acmesystems.it/) or imx233 (https://www.olimex.com/Products/OLinuXino/iMX233/iMX233-OLinuXino-MINI/open-source-hardware). For more info follow me on google+ and see http://arm926sdk.sourceforge.net/ . Also read ./UPGRADE_HINTS and ./docs/howto_arm926_sdk.txt .


For using the content of this repo first source armel_env. I add this to my .bashrc to automate it.

    # setup the arm926 environment 
    if [ -f ~/arm926_sdk/armel_env ]; then
       . ~/arm926_sdk/armel_env 
    fi


Useful make tags
-------------------

	make get_toolchain -> download (and install) toochain from sourceforce (depending on your arch -> x86_64 or armv7hf) 
	make get_external_repos -> clone some useful repos (see ./external/README)
	make get_latest_kernel -> download latest supported kernel version as tarball and install it to ./kernel/linux-$ARMEL_KERNEL_VER
	make clean -> clean all dirs and subdirs


Missing (will follow soon)
-------------
	make get_images -> download minimal image from sourceforce
