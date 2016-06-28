#!/usr/bin/env bash
################################################################################
#
# Title       :    get_image_tarballs.sh
#
# License:
#
# GPL
# (c) 2015, thorsten.johannvorderbrueggen@t-online.de
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
################################################################################
#
# Date/Beginn :    20.11.2015/08.11.2015
#
# Version     :    V0.02
#
# Milestones  :    V0.02 (nov 2015) -> some minor changes
#                  V0.01 (nov 2015) -> first functional version
#
# Requires    :
#
#
################################################################################
# Description
#
#   A simple tool to download the image tarballs
#
# Some features
#   - ...
#
# Notes
#   - ...
#
################################################################################
#

# VERSION-NUMBER
VER='0.02'

# if env is sourced
MISSING_ENV='false'

#
# latest version
#
# VER:
# -> kernel_arietta.tgz
# -> rootfs_arietta.tgz
# -> home_arietta.tgz
#
# DOWNLOAD_STRING:
# -> http://sourceforge.net/projects/arm926sdk/files/kernel_arietta.tgz
# -> http://sourceforge.net/projects/arm926sdk/files/rootfs_arietta.tgz
# -> http://sourceforge.net/projects/arm926sdk/files/home_arietta.tgz
#
KERNEL_IMAGE='none'
ROOTFS_IMAGE='none'
HOME_IMAGE='none'


# my usage method
my_usage()
{
    echo " "
    echo "+--------------------------------------------------------+"
    echo "| Usage: ./get_image_tarballs.sh                         |"
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
_temp="/tmp/get_image_tarballs.$$"
_log="/tmp/get_image_tarballs.log"


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


# --- create download string
create_download_string()
{
    KERNEL_IMAGE="http://sourceforge.net/projects/arm926sdk/files/kernel_arietta.tgz"
    ROOTFS_IMAGE="http://sourceforge.net/projects/arm926sdk/files/rootfs_arietta.tgz"
    HOME_IMAGE="http://sourceforge.net/projects/arm926sdk/files/home_arietta.tgz"

    echo "INFO: set kernel download string to $KERNEL_IMAGE"
    echo "INFO: set rootfs download string to $ROOTFS_IMAGE"
    echo "INFO: set home download string to $HOME_IMAGE"
}


# --- download image tarball
get_image_tarball()
{
    if [ "$KERNEL_IMAGE" = 'none' ]; then
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: KERNEL_IMAGE is  none!       |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi

    if [ "$ROOTFS_IMAGE" = 'none' ]; then
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: ROOTFS_IMAGE is  none!       |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi

    if [ "$HOME_IMAGE" = 'none' ]; then
	echo " "
	echo "+--------------------------------------+"
	echo "|                                      |"
	echo "|  ERROR: HOME_IMAGE is  none!         |"
	echo "|                                      |"
	echo "+--------------------------------------+"
	echo " "

	cleanup
    fi

    wget $KERNEL_IMAGE
    wget $ROOTFS_IMAGE
    wget $HOME_IMAGE
}


# ******************************************************************************
# ***                         Main Loop                                      ***
# ******************************************************************************

echo " "
echo "+----------------------------------------+"
echo "|  dowload latest image tarballs         |"
echo "+----------------------------------------+"
echo " "

cd $ARMEL_HOME/images

create_download_string
get_image_tarball

cleanup
echo " "
echo "+----------------------------------------+"
echo "|          Cheers $USER                |"
echo "+----------------------------------------+"
echo " "


############################# END OF ALL TIMES :-) ##############################

