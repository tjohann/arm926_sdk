#!/usr/bin/env bash
################################################################################
#
# Title       :    get_latest_linux_kernel.sh    
#
# Author      :    Thorsten Johannvorderbrueggen
#
# Email       :    thorsten.johannvorderbrueggen@t-online.de
#
# Date/Beginn :    13.04.2015
#
# Version     :    V0.01
#
# Milestones  :    V0.01 (apr 2015) -> first functional version
#
# Requires    :    
#                 
#
################################################################################
# Description
#   
#   A simple tool to get the latest kernel tarball and copy it to
#   $ARMEL_HOME/kernel ...  
#
# Some features
#   - ... 
#
# Notes
#   - ...
#
################################################################################

# VERSION-NUMBER
VER='0.01'

# if env is sourced 
MISSING_ENV='false'

# latest kernel version
KERNEL_VER='none'
KERNEL_DOWNLOAD_STRING='none'

# my usage method 
my_usage() 
{
    echo " "
    echo "+--------------------------------------------------------+"
    echo "| Usage: ./get_latest_linux_kernel.sh                    |"
    echo "|        [-v] -> print version info                      |"
    echo "|        [-h] -> this help                               |"
    echo "|                                                        |"
    echo "+--------------------------------------------------------+"
    echo " "
    exit
}

# my cleanup 
cleanup() {
   rm $_temp 2>/dev/null
   rm $_log 2>/dev/null
}

# my exit method 
my_exit() 
{
    clear
    echo "+-----------------------------------+"
    echo "|          Cheers $USER            |"
    echo "+-----------------------------------+"
    cleanup
    exit
}

# print version info
print_version() 
{
    echo "+-----------------------------------+"
    echo "| You are using version: ${VER}       |"
    echo "+-----------------------------------+"
    cleanup
    exit
}

# ---- Some values for internal use ----
_temp="/tmp/get_latest_linux_kernel.$$"
_log="/tmp/get_latest_linux_kernel.log"


# check the args 
while getopts 'hv' opts 2>$_log
do
    case $opts in
        h) my_usage ;;
	v) print_version ;;
        ?) my_usage ;;
    esac
done


# ******************************************************************************
# ***             Error handling for missing shell values                    ***
# ******************************************************************************

if [ "$ARMEL_HOME" = '' ]; then 
    MISSING_ENV='true'
fi

# show a usage screen and exit
if [ "$MISSING_ENV" = 'true' ]; then 
    cleanup
    clear
    echo " "
    echo "+--------------------------------------+"
    echo "|                                      |"
    echo "|  ERROR: missing env                  |"
    echo "|         have you sourced env-file?   |"
    echo "|                                      |"
    echo "|          Cheers $USER               |"
    echo "|                                      |"
    echo "+--------------------------------------+"
    echo " "
    exit
fi


# ******************************************************************************
# ***                      The functions for main_menu                       ***
# ******************************************************************************

# --- set latest supported kernel version
set_latest_kernel_version()
{
    if [ "$ARMEL_KERNEL_VER" = '' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: ARMEL_KERNEL_VER is empty!   |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi
    
    KERNEL_VER=$ARMEL_KERNEL_VER

    echo "INFO: set kernel version to linux-$KERNEL_VER"
}

# --- create download string with kernel version
create_download_string()
{
   if [ "$KERNEL_VER" = 'none' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: KERNEL_VER is none!          |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi 

   KERNEL_DOWNLOAD_STRING="https://www.kernel.org/pub/linux/kernel/v4.x/linux-${KERNEL_VER}.tar.xz"

   echo "INFO: set kernel download string to $KERNEL_DOWNLOAD_STRING"
}


# --- download kernel tarball
get_kernel_tarball()
{
    if [ "$KERNEL_DOWNLOAD_STRING" = 'none' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: KERNEL_DOWNLOAD_STRING is    |"
	echo "|         none!                        |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi 

    wget $KERNEL_DOWNLOAD_STRING
}

# --- untar kernel source
untar_kernel()
{
    if [ "$KERNEL_VER" = 'none' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: KERNEL_VER is none!          |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi
    
    if [ -f linux-${KERNEL_VER}.tar.xz ]; then
	tar xvf linux-${KERNEL_VER}.tar.xz 
    else
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: linux-${KERNEL_VER}.tar.xz   |"
	echo "|         does not exist!              |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi    
}


# ******************************************************************************
# ***                         Main Loop                                      ***
# ****************************************************************************** 

echo " "
echo "+----------------------------------------+"
echo "|    get/install latest kernel tarball   |"
echo "+----------------------------------------+"
echo " "

cd $ARMEL_HOME/kernel

set_latest_kernel_version
create_download_string
get_kernel_tarball
untar_kernel

cleanup
echo " "
echo "+----------------------------------------+"
echo "|          Cheers $USER                |"
echo "+----------------------------------------+"
echo " "


############################# END OF ALL TIMES :-) ##############################
