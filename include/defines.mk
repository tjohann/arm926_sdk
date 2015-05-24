################################################################################
#
# Title       :    defines.mk    
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
# Description:
#   Common defines for all code used within this sdk.
#
# Usage:
#   - source armel_env_v[1-9]
#   - add this to the makefile
#   SNIP
#   include ${ARMEL_HOME}/include/defines.mk
#   SNIP
#
################################################################################
#

# ---- host ----
CC = gcc
AR = ar
LD = ld

CFLAGS = -I${ARMEL_HOME}/include -g -Wall -Wextra -std=gnu11
LDLIBS = -L${ARMEL_HOME}/lib


# ---- target ----
ifeq (,$(filter ${MY_HOST_ARCH},"x86_64" "armv7l"))
	CC_TARGET = arm-none-linux-gnueabi-gcc
	AR_TARGET = arm-none-linux-gnueabi-ar
	LD_TARGET = arm-none-linux-gnueabi-ld
else
	CC_TARGET = gcc
	AR_TARGET = ar
	LD_TARGET = ld
endif

CFLAGS_TARGET = -I${ARMEL_HOME}/include -g -Wall -Wextra -std=gnu11
LDLIBS_TARGET = -L${ARMEL_HOME}/lib_target

