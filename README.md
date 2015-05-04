ARM926_SDK
=========

This is my sdk for usage with slackware hosts on x86_64 or armv7l for arm926 target devices like aria g25 and arietta (see http://www.acmesystems.it/). For more info follow me on google+ and see http://arm926sdk.sourceforge.net/


For using the content of this repo first source armel_env_v1. I add this to my .bashrc to automate it.


    # setup the arm926 environment
    if [ -f ~/arm926_sdk/armel_env_v1 ]; then
       . ~/arm926_sdk/armel_env_v1 
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