ARM926_SDK
=========

This is my arm926te sdk for usage with x86_64 or armv7hf host to develop for devices like [arietta](http://www.acmesystems.it/) or [imx233](https://www.olimex.com/Products/OLinuXino/iMX233/iMX233-OLinuXino-MINI/open-source-hardware). For more info follow me on google+ and see [sourceforge](http://arm926sdk.sourceforge.net/) . Also read ./UPGRADE_HINTS and ./docs/info_arm926_sdk.txt .



Usage
-------------------

Clone the repo into your home directory:

        git clone https://github.com/tjohann/arm926_sdk.git


After cloning, "source" the env file to set the necessary environment variables. You can either set this to run automatically via a .bashrc entry as outlined below..

        # setup the arm926 environment
        if [ -f ~/arm926_sdk/armel_env ]; then
            . ~/arm926_sdk/armel_env 
        fi


.. or do it manually everytime you want to work with the sdk. 

        . ./armel_env

Note: the env file also extends the PATH so it may cause errors when building other projects/repositories	


Download and installation of the toolchain, kernel and image are done via small scripts in $ARMEL_HOME/bin.
To download and install the toolchain, type

        make get_toolchain


Now you should have a working compiler to cross compile for an armv5te target like the Arietta.


Additional Commands
-------------------

To download the images for the target, type

        make get_image_tarballs


To download the latest non-rt and rt kernel, type

        make get_latest_kernel


Useful make tags
-------------------

	make get_toolchain -> download (and install) toochain from sourceforce
	make get_external_repos -> clone additional repos (see ./external/README)
	make get_latest_kernel -> download latest supported kernel version as tarball and install it to ./kernel/linux-$ARMEL_KERNEL_VER
	                          download latest of RT-PREEMPT supported kernel and latest supported RT-PREEMPT-Patch 
	make get_image_tarballs -> download minimal image from sourceforce to ./images/				  
	make clean -> clean all dirs and subdirs


Projects
-------------------

    LED-DOT based clock -> see $ARMEL_HOME/projects/led_dot_clock/[README.md](LED-DOT based clock) 	