#!/bin/sh
# +------------------------- setup the armel dev environment ------------------------+
# |                                   armel_env_v1                                   |
# +----------------------------------------------------------------------------------+

# set MY_HOST_ARCH
export MY_HOST_ARCH=$(uname -m)

# set correct version
export ARMEL_VER=v1

# set armel home
export ARMEL_HOME=/opt/arm926_sdk

# extend PATH for my armel stuff
export PATH=${ARMEL_HOME}/${ARMEL_VER}/bin:${ARMEL_HOME}/bin:$PATH

echo "Setup env for host \"${MY_HOST_ARCH}\" with root dir \"${ARMEL_HOME}\" and version \"${ARMEL_VER}\""

#EOF
