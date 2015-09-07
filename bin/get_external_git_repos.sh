#!/usr/bin/env bash
################################################################################
#
# Title       :    get_external_git_repos.sh
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
# Date/Beginn :    07.09.2015/13.04.2015
#
# Version     :    V0.06
#
# Milestones  :    V0.06 (sep 2015) -> add slLIN 
#                  V0.05 (jun 2015) -> add can-utils and libsocketcan
#                  V0.04 (may 2015) -> add license 
#                  V0.03 (may 2015) -> add u-boot, olimex docs and mydriver
#                                   -> remove rpusbdisp (i have no more access
#                                      to it)
#                                   -> add common function cheers_users
#                                   -> some cleanups and output improvement
#                  V0.02 (may 2015) -> fix wrong case tag -> at91bootstrap missing
#                  V0.01 (apr 2015) -> first functional version
#
# Requires    :    ...
#                 
#
################################################################################
# Description
#   
#   A simple tool to get externel git repos like ipipe, xenomai, at91boot, ...  
#
# Some features
#   - clone repo with all 3 possible network protocols
#
# Notes
#   - ...
#
# Improvement/missing feature
#   - add a file with all possible repos instead of hardcoded values
#   - clone repos not only to ${ARMEL_HOME}/external ... clone to the current
#     working dir
#
################################################################################
#

# VERSION-NUMBER
VER='0.06'

# if env is sourced 
MISSING_ENV='false'

# REPOs
# at91bootstrap -> git://github.com/tanzilli/at91bootstrap.git
# linus -> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
# rt-tests -> http://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
# ipipe -> git://git.xenomai.org/ipipe.git/
# xenomai -> git://git.xenomai.org/xenomai-3.git/
# olimex-docs -> http://github.com/OLIMEX/OLINUXINO.git
# uboot -> git://git.denx.de/u-boot.git
# mydriver -> https://github.com/tjohann/mydriver.git
# can-utils -> https://github.com/linux-can/can-utils.git
# libsocketcan -> git://git.pengutronix.de/git/tools/libsocketcan.git
# sllin -> git://rtime.felk.cvut.cz/linux-lin.git
REPO='none'

# PROTOCOL
# git -> git
# http -> http
# https -> https
PROTOCOL='none'

# REPO_NAME
# {$PROTOCOL$get_repo_name()}
REPO_NAME='none'

# my usage method 
my_usage() 
{
    echo " "
    echo "+--------------------------------------------------------+"
    echo "| Usage: ./get_external_git_repos.sh                     |"
    echo "|        [-r REPO] -> name of the sdk                    |"
    echo "|        [-p PROTOCOL] -> git/http/https                 |"
    echo "|        [-v] -> print version info                      |"
    echo "|        [-h] -> this help                               |"
    echo "|                                                        |"
    echo "| Example:                                               |"
    echo "| get_external_git_repos.sh -r xenomai -p http           |"
    echo "|                                                        |"
    echo "| Valid repo names:                                      |"
    echo "| REPO: none or empty -> clone all repos below           |"
    echo "| REPO: at19bootstrap                                    |"
    echo "| REPO: linus -> linus kernel tree                       |"
    echo "| REPO: rpusbdisp -> robopeak usb display                |"
    echo "| REPO: rt-tests -> rt-test tools                        |"
    echo "| REPO: xenomai -> xenomai microkernel                   |"
    echo "| REPO: ipipe -> int pipe                                |"
    echo "| REPO: uboot -> denx u-boot                             |"
    echo "| REPO: olimex-docs -> olimex github repo (for imx233)   |"
    echo "| REPO: mydriver -> my test driver                       |"
    echo "| REPO: can-utils -> common can-utils                    |"
    echo "| REPO: libsocketcan -> pengutronix libsocketcan         |"
    echo "| REPO: sllin -> linux lin driver                        |"
    echo "|                                                        |"
    echo "| Valid network protocols:                               |"
    echo "| PROTOCOL: none or empty -> use the simple git          |"
    echo "| PROTOCOL: git                                          |"
    echo "| PROTOCOL: http                                         |"
    echo "| PROTOCOL: https                                        |"
    echo "+--------------------------------------------------------+"
    echo " "
    exit
}

# my cleanup 
cleanup() {
   rm $_temp 2>/dev/null
   rm $_log 2>/dev/null
}

# cheers user
cheers_user()
{
    echo "+--------------------------------------------------------+"
    echo "|                                                        |"
    echo "|                  Cheers $USER "
    echo "|                                                        |"
    echo "+--------------------------------------------------------+"
}

# cheers because of missing env
cheers_missing_env()
{
    cleanup
    clear
    echo " "
    echo "+--------------------------------------------------------+"
    echo "|                                                        |"
    echo "|  ERROR: missing env                                    |"
    echo "|         have you sourced env-file?                     |"
    echo "|                                                        |"
    echo "|          Cheers $USER     "
    echo "|                                                        |"
    echo "+--------------------------------------------------------+"
    echo " "
    exit
}

# my exit method 
my_exit() 
{
    clear
    cheers_user
    cleanup
    exit
}

# print version info
print_version() 
{
    echo "+--------------------------------------------------------+"
    echo "|                                                        |"
    echo "|           You are using version: ${VER}                  |"
    echo "|                                                        |"
    echo "+--------------------------------------------------------+"
    cleanup
    exit
}

# ---- Some values for internal use ----
_temp="/tmp/get_external_git_repos.$$"
_log="/tmp/get_external_git_repos.log"


# check the args 
while getopts 'hvr:p:' opts 2>$_log
do
    case $opts in
        h) my_usage ;;
	v) print_version ;;
	r) REPO=$OPTARG ;;
	p) PROTOCOL=$OPTARG ;;
        ?) my_usage ;;
    esac
done


# ******************************************************************************
# ***                 error handling for missing env                         ***
# ******************************************************************************

if [ "$ARMEL_HOME" = '' ]; then 
    MISSING_ENV='true'
fi

# check and maybe exit
if [ "$MISSING_ENV" = 'true' ]; then 
    cheers_missing_env
fi


# ******************************************************************************
# ***                     the functions for main_menu                        ***
# ******************************************************************************

# --- set repo names
set_repo_names()
{
    at91bootstrap="://github.com/tanzilli/at91bootstrap.git"
    linus="://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
    rt_tests="://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git"
    ipipe="://git.xenomai.org/ipipe.git/"
    xenomai="://git.xenomai.org/xenomai-3.git/"
    olimex_docs="://github.com/OLIMEX/OLINUXINO.git"
    uboot="://git.denx.de/u-boot.git"
    mydriver="://github.com/tjohann/mydriver.git"
    can_utils="://github.com/linux-can/can-utils.git"
    libsocketcan="://git.pengutronix.de/git/tools/libsocketcan.git"
    sllin="://rtime.felk.cvut.cz/linux-lin.git"
    
    
    # array with all available repos
    repo_names_array[0]=${at91bootstrap}
    repo_names_array[1]=${linus}
    repo_names_array[2]=${rt_tests}
    repo_names_array[3]=${ipipe}
    repo_names_array[4]=${xenomai}
    repo_names_array[5]=${olimex_docs}
    repo_names_array[6]=${uboot}
    repo_names_array[7]=${mydriver}
    repo_names_array[8]=${can_utils}
    repo_names_array[9]=${libsocketcan}
    repo_names_array[10]=${sllin}
}


# --- get repo name
get_repo_name()
{
    case "$REPO" in
	'at91bootstrap')
	    REPO_NAME="${PROTOCOL}${at91bootstrap}"
	    ;;
	'linus')
	    REPO_NAME="${PROTOCOL}${linus}"
	    ;;
	'rt-tests')
	    REPO_NAME="${PROTOCOL}${rt_tests}"
	    ;;
	'ipipe')
	    REPO_NAME="${PROTOCOL}${ipipe}"
	    ;;
	'xenomai')
	    REPO_NAME="${PROTOCOL}${xenomai}"
	    ;;
	'olimex-docs')
	    REPO_NAME="${PROTOCOL}${olimex_docs}"
	    ;;
	'uboot')
	    REPO_NAME="${PROTOCOL}${uboot}"
	    ;;
	'mydriver')
	    REPO_NAME="${PROTOCOL}${mydriver}"
	    ;;
	'can-utils')
	    REPO_NAME="${PROTOCOL}${can_utils}"
	    ;;
	'libsocketcan')
	    REPO_NAME="${PROTOCOL}${libsocketcan}"
	    ;;
	'sllin')
	    REPO_NAME="${PROTOCOL}${sllin}"
	    ;;
	*)
	    echo "ERROR -> ${REPO} is no valid repo ... pls check"
	    my_usage
    esac
}


# --- get repo name
check_protocol()
{
    PROTOCOL_VALID='false'
    
    if [ $PROTOCOL = 'git' -o $PROTOCOL = 'GIT' ]; then
	PROTOCOL='git'
	PROTOCOL_VALID='true'
    fi

    if [ $PROTOCOL = 'http' -o $PROTOCOL = 'HTTP' ]; then
	PROTOCOL='http'
	PROTOCOL_VALID='true'
    fi

    if [ $PROTOCOL = 'https' -o $PROTOCOL = 'HTTPS' ]; then
	PROTOCOL='https'
	PROTOCOL_VALID='true'
    fi

    if [ $PROTOCOL_VALID = 'false' ]; then
	echo "ERROR -> ${PROTOCOL} is no valid network protocol ... pls check"
	my_usage
    fi
}


# --- clone the repo
clone_repo()
{
    echo "start to clone repo $REPO_NAME"
    git clone $REPO_NAME
}


# --- clone all repos
clone_all_repos()
{
    for item in ${repo_names_array[*]}
    do
	REPO_NAME="${PROTOCOL}${item}"
	clone_repo
    done
}


# ******************************************************************************
# ***                         Main Loop                                      ***
# ****************************************************************************** 

echo " "
echo "+--------------------------------------------------------+"
echo "|                                                        |"
echo "|                 get external git repos                 |"
echo "|                                                        |"
echo "+--------------------------------------------------------+"
echo " "

cd ${ARMEL_HOME}/external
set_repo_names 

if [ $PROTOCOL = 'none' ]; then
    echo "PROTOCOL == none -> using git"
    PROTOCOL='git'
else
    check_protocol 
fi

if [ $REPO = 'none' ]; then
    echo "REPO == none -> clone all repos"
    REPO_NAME='all'
    clone_all_repos 
else
    echo "will clone ${REPO}"
    get_repo_name 
    clone_repo 
fi

cleanup
echo " "
cheers_user
echo " "


############################# END OF ALL TIMES :-) ##############################

