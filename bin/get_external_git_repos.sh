#!/usr/bin/env bash
################################################################################
#
# Title       :    get_external_git_repos.sh    
#
# Author      :    Thorsten Johannvorderbrueggen
#
# Email       :    thorsten.johannvorderbrueggen@t-online.de
#
# Date/Beginn :    04.05.2015
#
# Version     :    V0.02
#
# Milestones  :    V0.02 (may 2015) -> fix wrong case tag -> at91bootstrap missing
#                  V0.01 (apr 2015) -> first functional version
#
# Requires    :    
#                 
#
################################################################################
# Description
#   
#   A simple tool to get externel git repos like ipipe, xenomai, at91boot, ...  
#
# Some features
#   - ... 
#
# Notes
#   - ...
#
################################################################################

# VERSION-NUMBER
VER='0.02'

# if env is sourced 
MISSING_ENV='false'

# REPOs
# at91bootstrap -> git://github.com/tanzilli/at91bootstrap.git
# linus -> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
# rpusbdisp -> http://github.com/robopeak/rpusbdisp.git
# rt-tests -> http://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
# ipipe -> git://git.xenomai.org/ipipe.git/
# xenomai -> git://git.xenomai.org/xenomai-3.git/
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
    echo "|        [-r REPO] -> version of the sdk                 |"
    echo "|        [-p PROTOCOL] -> git/http/https                 |"
    echo "|        [-v] -> print version info                      |"
    echo "|        [-h] -> this help                               |"
    echo "|                                                        |"
    echo "| REPO: none or empty -> clone all repos below           |"
    echo "| REPO: at19bootstrap                                    |"
    echo "| REPO: linus -> linus kernel tree                       |"
    echo "| REPO: rpusbdisp -> robopeak usb display                |"
    echo "| REPO: rt-tests -> rt-test tools                        |"
    echo "| REPO: xenomai -> xenomai microkernel                   |"
    echo "| REPO: ipipe -> int pipe                                |"
    echo "|                                                        |"
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

# --- set repo names
set_repo_names()
{
    at91bootstrap="://github.com/tanzilli/at91bootstrap.git"
    linus="://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
    rpusbdisp="://github.com/robopeak/rpusbdisp.git"
    rt_tests="://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git"
    ipipe="://git.xenomai.org/ipipe.git/"
    xenomai="://git.xenomai.org/xenomai-3.git/"
    
    # array with all available repos
    repo_names_array[0]=${at91bootstrap}
    repo_names_array[1]=${linus}
    repo_names_array[2]=${rpusbdisp}
    repo_names_array[3]=${rt_tests}
    repo_names_array[4]=${ipipe}
    repo_names_array[5]=${xenomai}
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
	'rpusbdisp')
	    REPO_NAME="${PROTOCOL}${rpusbdisp}"
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
	*)
	    echo "ERROR -> ${REPO} is no valid argument"
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
	echo "ERROR -> ${PROTOCOL} is no valid argument"
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
echo "+--------------------------------------+"
echo "|       get external git repos         |"
echo "+--------------------------------------+"
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
echo "+--------------------------------------+"
echo "|          Cheers $USER               |"
echo "+--------------------------------------+"
echo " "


############################# END OF ALL TIMES :-) ##############################

