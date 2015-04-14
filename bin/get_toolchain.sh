#!/usr/bin/env bash
################################################################################
#
# Title       :    get_toolchain.sh    
#
# Author      :    Thorsten Johannvorderbrueggen
#
# Email       :    thorsten.johannvorderbrueggen@t-online.de
#
# Date/Beginn :    14.04.2015
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
#   A simple tool to get the toolchain and untar it to $ARMEL_HOME  ...  
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
TOOLCHAIN_VER='none'
TOOLCHAIN_DOWNLOAD_STRING='none'

# my usage method 
my_usage() 
{
    echo " "
    echo "+--------------------------------------------------------+"
    echo "| Usage: ./get_toolchain.sh                              |"
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
_temp="/tmp/get_toolchain.$$"
_log="/tmp/get_toolchain.log"


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

# --- set latest toolchain version
set_toolchain_version()
{
    if [ "$ARMEL_VER" = '' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: ARMEL_VER is empty!          |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi

    if [ "$MY_HOST_ARCH" = '' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: MY_HOST_ARCH is empty!          |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi

    #
    # There's only support armv7l (cubietruck) and x86_64 (EMT64 ...)
    #
    if [ "$MY_HOST_ARCH" = 'x86_64' ]; then
       TOOLCHAIN_VER=${ARMEL_VER}_${MY_HOST_ARCH}
    fi

    if [ "$MY_HOST_ARCH" = 'armv7l' ]; then
       TOOLCHAIN_VER=${ARMEL_VER}_${MY_HOST_ARCH}
    fi
       
    if [ "$TOOLCHAIN_VER" = 'none' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: TOOLCHAIN_VER==none          |"
	echo "|                                      |"
	echo "|  Check values of:                    |"
	echo "|  -> $MY_HOST_ARCH                     "
	echo "|  -> $ARMEL_VER                        "
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi
  
    echo "INFO: set toolchain version to $TOOLCHAIN_VER"
}

# --- create download string 
create_download_string()
{
   if [ "$TOOLCHAIN_VER" = 'none' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: TOOLCHAIN_VER is none!       |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi 

   TOOLCHAIN_DOWNLOAD_STRING="http://sourceforge.net/projects/arm926sdk/files/${TOOLCHAIN_VER}.tgz"

   echo "INFO: set kernel download string to $TOOLCHAIN_DOWNLOAD_STRING"
}


# --- download toolchain tarball
get_toolchain_tarball()
{
    if [ "$TOOLCHAIN_DOWNLOAD_STRING" = 'none' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: TOOLCHAIN_DOWNLOAD_STRING is |"
	echo "|         none!                        |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi 

    wget $TOOLCHAIN_DOWNLOAD_STRING
}

# --- untar toolchain source
untar_toolchain()
{
    if [ "$TOOLCHAIN_VER" = 'none' ]; then 
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: TOOLCHAIN_VER is none!       |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi
    
    if [ -f ${TOOLCHAIN_VER}.tgz ]; then
	tar xzvf ${TOOLCHAIN_VER}.tgz 
    else
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: ${TOOLCHAIN_VER}.tgz does    |"
	echo "|         not exist!                   |"
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
echo "|  get/install latest toolchain tarball  |"
echo "+----------------------------------------+"
echo " "

cd $ARMEL_HOME

set_toolchain_version
create_download_string
get_toolchain_tarball
untar_toolchain

cleanup
echo " "
echo "+----------------------------------------+"
echo "|          Cheers $USER                |"
echo "+----------------------------------------+"
echo " "


############################# END OF ALL TIMES :-) ##############################

