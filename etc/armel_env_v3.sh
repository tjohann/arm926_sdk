# +------------------------- setup the armel dev environment ------------------------+
# |                                   armel_env_v3                                   |
# +----------------------------------------------------------------------------------+

# set MY_HOST_ARCH
export MY_HOST_ARCH=$(uname -m)

# set correct version
export ARMEL_VER=v3

# set supported kernel version
export ARMEL_KERNEL_VER=4.0.4

# set armel home
export ARMEL_HOME=/opt/arm926_sdk

# extend PATH for my armel stuff
export PATH=${ARMEL_HOME}/${ARMEL_VER}/bin:${ARMEL_HOME}/host_${ARMEL_VER}/usr/bin:${ARMEL_HOME}/bin:$PATH

# set mount points for the sdcard -> arietta
export ARIETTA_MEDIA_KERNEL=/mnt/arietta_kernel
export ARIETTA_MEDIA_ROOTFS=/mnt/arietta_rootfs
export ARIETTA_MEDIA_HOME=/mnt/arietta_home

echo "Setup env for host \"${MY_HOST_ARCH}\" with root dir \"${ARMEL_HOME}\" and version \"${ARMEL_VER}\""

#EOF