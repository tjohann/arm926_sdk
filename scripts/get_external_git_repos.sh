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
# Date/Beginn :    07.09.2015/15.08.2015
#
# Version     :    V0.07
#
# Milestones  :    V0.07 (sep 2015) -> add linux-lin driver repos
#                  V0.06 (sep 2015) -> add our baalue repos
#                  V0.05 (aug 2015) -> add can4linux svn repot
#                  V0.04 (aug 2015) -> add erika svn repo
#                                      remove ipipe and xenomai (we wont use it)
#                  V0.03 (aug 2015) -> add jailhouse and allwinner docs
#                  V0.02 (aug 2015) -> add void repo
#                  V0.01 (aug 2015) -> first functional version
#
# Requires    :    ...
#                 
#
################################################################################
# Description
#   
#   A simple tool to get externel git repos like linux kernel, erika ...  
#
# Some features
#   - clone repo with all 3 possible network protocols
#   - checkout svn repo 
#
# Notes
#   - ...
#
# Improvement/missing feature
#   - add a file with all possible repos instead of hardcoded values
#   - clone repos not only to ${BAALUE_HOME}/external ... clone to the current
#     working dir
#
################################################################################
#

# VERSION-NUMBER
VER='0.07'

# if env is sourced 
MISSING_ENV='false'

# REPOs
# linus -> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
# rt-tests -> http://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
# uboot -> git://git.denx.de/u-boot.git
# mydriver -> https://github.com/tjohann/mydriver.git
# can-utils -> https://github.com/linux-can/can-utils.git
# libsocketcan -> git://git.pengutronix.de/git/tools/libsocketcan.git
# void-packages -> https://github.com/voidlinux/void-packages.git
# jailhouse -> git://github.com/siemens/jailhouse.git
# allwinner -> http://github.com/allwinner-zh/documents.git
# libbaalue -> https://github.com/tjohann/libbaalue.git
# baalue -> https://github.com/tjohann/baalue.git
# baalued -> https://github.com/tjohann/baalued.git
# erika -> svn://svn.tuxfamily.org/svnroot/erika/erikae/repos/ee/trunk/ee
# can4linux -> https://svn.code.sf.net/p/can4linux/code/trunk
# sllin ->  sllin="://rtime.felk.cvut.cz/linux-lin.git"
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
    echo "| REPO: linus -> linus kernel tree                       |"
    echo "| REPO: rt-tests -> rt-test tools                        |"
    echo "| REPO: uboot -> denx u-boot                             |"
    echo "| REPO: mydriver -> my test driver                       |"
    echo "| REPO: can-utils -> common can-utils                    |"
    echo "| REPO: libsocketcan -> pengutronix libsocketcan         |"
    echo "| REPO: void-packages -> void-packages                   |"
    echo "| REPO: jailhouse -> jailhouse hypervisor                |"
    echo "| REPO: allwinner -> allwinners docs                     |"
    echo "| REPO: erika -> Erika svn repo                          |"
    echo "| REPO: can4linux -> can4linux (A20 CAN support)         |"
    echo "| REPO: libbaalue -> our foundation lib                  |"
    echo "| REPO: baalue -> our user tool                          |"
    echo "| REPO: baalued -> our baalue daemon                     |"
    echo "| REPO: sllin -> linux lin driver                        |"
    echo "|                                                        |"
    echo "| Valid network protocols:                               |"
    echo "| PROTOCOL: none or empty -> use the simple git          |"
    echo "| PROTOCOL: git                                          |"
    echo "| PROTOCOL: http                                         |"
    echo "| PROTOCOL: https                                        |"
    echo "| PROTOCOL: svn                                          |"
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

if [ "$BAALUE_HOME" = '' ]; then 
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
    linus="://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
    rt_tests="://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git"
    uboot="://git.denx.de/u-boot.git"
    mydriver="://github.com/tjohann/mydriver.git"
    can_utils="://github.com/linux-can/can-utils.git"
    libsocketcan="://git.pengutronix.de/git/tools/libsocketcan.git"
    void_packages="://github.com/voidlinux/void-packages.git"
    jailhouse="://github.com/siemens/jailhouse.git"
    allwinner="://github.com/allwinner-zh/documents.git"
    erika="svn://svn.tuxfamily.org/svnroot/erika/erikae/repos/ee/trunk/ee"
    can4linux="https://svn.code.sf.net/p/can4linux/code/trunk/"
    libbaalue="://github.com/tjohann/libbaalue.git"
    baalue="://github.com/tjohann/baalue.git"
    baalued="://github.com/tjohann/baalued.git"
    sllin="://rtime.felk.cvut.cz/linux-lin.git"
    
    
    # array with all available repos
    repo_names_array[0]=${linus}
    repo_names_array[1]=${rt_tests}
    repo_names_array[2]=${uboot}
    repo_names_array[3]=${mydriver}
    repo_names_array[4]=${can_utils}
    repo_names_array[5]=${libsocketcan}
    repo_names_array[6]=${void_packages}
    repo_names_array[7]=${jailhouse}
    repo_names_array[8]=${allwinner}
    repo_names_array[9]=${erika}
    repo_names_array[10]=${can4linux}
    repo_names_array[11]=${libbaalue}
    repo_names_array[12]=${baalue}
    repo_names_array[13]=${baalued}
    repo_names_array[14]=${sllin}    
}


# --- get repo name
get_repo_name()
{
    case "$REPO" in
	'linus')
	    REPO_NAME="${PROTOCOL}${linus}"
	    ;;
	'rt-tests')
	    REPO_NAME="${PROTOCOL}${rt_tests}"
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
	'void-packages')
	    REPO_NAME="${PROTOCOL}${void_packages}"
	    ;;
	'jailhouse')
	    REPO_NAME="${PROTOCOL}${jailhouse}"
	    ;;
	'allwinner')
	    REPO_NAME="${PROTOCOL}${allwinner}"
	    ;;
	'erika')
	    # svn repo
	    REPO_NAME="${erika}"
	    ;;
	'can4linux')
	    # svn repo
	    REPO_NAME="${can4linux}"
	    ;;
	'libbaalue')
	    REPO_NAME="${PROTOCOL}${libbaalue}"
	    ;;
	'baalue')
	    REPO_NAME="${PROTOCOL}${baalue}"
	    ;;
	'baalued')
	    REPO_NAME="${PROTOCOL}${baalued}"
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

    if [ $PROTOCOL = 'svn' -o $PROTOCOL = 'SVN' ]; then
	PROTOCOL='svn'
	PROTOCOL_VALID='true'
    fi

    if [ $PROTOCOL_VALID = 'false' ]; then
	echo "ERROR -> ${PROTOCOL} is no valid network protocol ... pls check"
	my_usage
    fi
}


# --- checkout erika -> svn repo
checkout_erika()
{
    echo "checkout erika"
    svn co $REPO_NAME
}


# --- checkout can4linux -> svn repo
checkout_can4linux()
{
    echo "checkout can4linux"
    svn co $REPO_NAME can4linux-code
}


# --- clone the repo
clone_repo()
{
    echo "start to clone repo $REPO_NAME"
    
    if [ $PROTOCOL = 'svn' ]; then
	if [ $REPO = 'can4linux' ]; then
	    svn co $REPO_NAME can4linux-code
	else
	    echo "clone a svn repo"
	    svn co $REPO_NAME
	fi
    else
	git clone $REPO_NAME
    fi
}


# --- clone all repos
clone_all_repos()
{
    for item in ${repo_names_array[*]}
    do
	if [ $item = $erika ]; then
	    # handle svn repo for erika
	    REPO_NAME="${item}"
	    checkout_erika
	elif [ $item = $can4linux ]; then
	    # handle svn repo for can4linux
	    REPO_NAME="${can4linux}"
	    checkout_can4linux    
	else
	    REPO_NAME="${PROTOCOL}${item}"
	    clone_repo
	fi
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

cd ${BAALUE_HOME}/external
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

