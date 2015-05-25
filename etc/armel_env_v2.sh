# +------------------------- setup the armel dev environment ------------------------+
# |                                   armel_env_v2                                   |
# +----------------------------------------------------------------------------------+

# set MY_HOST_ARCH
export MY_HOST_ARCH=$(uname -m)

# set correct version
export ARMEL_VER=v2

# set supported kernel version
export ARMEL_KERNEL_VER=4.0.4

# set armel home
export ARMEL_HOME=/opt/arm926_sdk

# extend PATH for my armel stuff
export PATH=${ARMEL_HOME}/${ARMEL_VER}/bin:${ARMEL_HOME}/bin:$PATH

# extend MANPATH for my armel stuff
export MANPATH=${ARMEL_HOME}/man/:$MANPATH

# extend CDPATH for my armel stuff
export CDPATH=${ARMEL_HOME}/

# set mount points for the sdcard -> arietta
export ARIETTA_MEDIA_KERNEL=/mnt/arietta_kernel
export ARIETTA_MEDIA_ROOTFS=/mnt/arietta_rootfs
export ARIETTA_MEDIA_HOME=/mnt/arietta_home

# set mount points for the sdcard -> imx233
export IMX233_MEDIA_KERNEL=/mnt/imx233_kernel
export IMX233_MEDIA_ROOTFS=/mnt/imx233_rootfs
export IMX233_MEDIA_HOME=/mnt/imx233_home

echo "Setup env for host \"${MY_HOST_ARCH}\" with root dir \"${ARMEL_HOME}\" and version \"${ARMEL_VER}\""

#EOF
