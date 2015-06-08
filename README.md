ARM926_SDK
=========

This is my sdk for usage with slackware hosts on x86_64 or armv7hl for arm926 target devices like arietta (see http://www.acmesystems.it/) or imx233 (https://www.olimex.com/Products/OLinuXino/iMX233/iMX233-OLinuXino-MINI/open-source-hardware). For more info follow me on google+ and see http://arm926sdk.sourceforge.net/ . Also read ./UPGRADE_HINTS and ./docs/howto_arm926_sdk.txt .


For using the content of this repo first source armel_env_v1. I add this to my .bashrc to automate it.


    # setup the arm926 environment (latest stable)
    if [ -f ~/arm926_sdk/armel_env_v1 ]; then
       . ~/arm926_sdk/armel_env_v1 
    fi

of

    # setup the arm926 environment (latest work output -> current )
    if [ -f ~/arm926_sdk/armel_env_v2 ]; then
       . ~/arm926_sdk/armel_env_v2 
    fi


Useful make tags
-------------------

	make get_toolchain -> download (and install) toochain from sourceforce (depending on your arch -> x86_64 or armv7l) based on the version sourced by armel_env_v[1...] 
	make get_external_repos -> clone some useful repos (see ./external/README)
	make get_latest_kernel -> download latest supported kernel version as tarball and install it to ./kernel/linux-$ARMEL_KERNEL_VER
	make clean -> clean all dirs and subdirs


Missing (will follow soon)
-------------
	make get_images -> download minimal image from sourceforce
	make docs -> create html and/or pdf docs
	make man -> install some man pages to ${ARMEL_HOME}/man