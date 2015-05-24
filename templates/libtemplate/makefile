################################################################################
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
include ${ARMEL_HOME}/include/defines.mk
DEPENDFILE = .depend

LIBNAME = $(shell echo "${PWD}" | sed 's!.*/!!')
PKGNAME = ${LIBNAME}-${VERSION}

VERSION = $(shell cat VERSION)
ARRAY_VER=(${VERSION//./ })
VER_MAYOR=${ARRAY_VER[0]}
VER_MINOR=${ARRAY_VER[1]}
VER_BUGFIX=${ARRAY_VER[2]}

SRC = $(LIBNAME).c
OBJ = $(LIBNAME).o
HDR = $(LIBNAME).h

CFLAGS += -O2 -fPIC
CFLAGS += -DVERSION=\"$(VERSION)\" 
LDLIBS = -lpthread -shared -Wl,-soname,$(LIBNAME).so.$(VER_MAYOR) -lc

CFLAGS_TARGET += -O2 -fPIC
CFLAGS_TARGET += -DVERSION=\"$(VERSION)\" 
LDLIBS_TARGET = -lpthread -shared -Wl,-soname,$(LIBNAME).so.$(VER_MAYOR) -lc


all: $(LIBNAME).host $(LIBNAME).target

host: $(LIBNAME).host 

target:	$(LIBNAME).target 

# 
# build on host (x86_64 or armv7l)
#
%.host: $(SRC) $(HEADER)
	@echo "+-----------------------------------------------------+"
	@echo "|                                                     |"
	@echo "| building ${LIBNAME} on host ${MY_HOST_ARCH} "
	@echo "|                                                     |"
	@echo "+-----------------------------------------------------+"
	${CC} $(CFLAGS) -c $(SRC) 
	${CC} $(CFLAGS) -o $(LIBNAME).so.$(VERSION) $(OBJ) $(LDLIBS)
	${AR} rcs $(LIBNAME).a $(OBJ)
	mv ${LIBNAME}.a _lib
	mv ${LIBNAME}.so.$(VERSION) _lib

# 
# crossbuild for target (arm926)
#
%.target: $(SRC) $(HEADER)
	@echo "+-----------------------------------------------------+"
	@echo "|                                                     |"
	@echo "| building ${LIBNAME} for target "
	@echo "|                                                     |"
	@echo "+-----------------------------------------------------+"
	${CC_TARGET} $(CFLAGS_TARGET) -c $(SRC)
	${CC_TARGET} $(CFLAGS_TARGET) -o ${LIBNAME}.so.$(VERSION) ${OBJ} $(LDLIBS_TARGET)
	${AR_TARGET} rcs $(LIBNAME).a $(OBJ)	
	mv ${LIBNAME}.a _lib_target
	mv ${LIBNAME}.so.$(VERSION) _lib_target

depend:: 
	gcc -E -MM  $(SRC) > $(DEPENDFILE)


clean::		
	rm -f *~ .*~ *.o *.i *.s *.so *.so.* *.a
	rm -f _lib/${LIBNAME}.*
	rm -f _lib_target/${LIBNAME}.*
	rm -f man/*~ 


deploy_man_page::
	@echo "+-----------------------------------------------------+"
	@echo "|                                                     |"
	@echo "| deploy man page to ${ARMEL_HOME}/... "
	@echo "|                                                     |"
	@echo "+-----------------------------------------------------+"
	cp man/*.3 $(ARMEL_HOME)/man/man3/


deploy_libs: $(LIBNAME).host $(LIBNAME).target
	@echo "+-----------------------------------------------------+"
	@echo "|                                                     |"
	@echo "| deploy libs to ${ARMEL_HOME}/... "
	@echo "|                                                     |"
	@echo "+-----------------------------------------------------+"
	cp _lib_target/${LIBNAME}.a ${ARMEL_HOME}/lib_target
	cp _lib_target/${LIBNAME}.so.${VERSION} ${ARMEL_HOME}/lib_target
	cp _lib/${LIBNAME}.a ${ARMEL_HOME}/lib
	cp _lib/${LIBNAME}.so.${VERSION} ${ARMEL_HOME}/lib
	cp ${LIBNAME}.h ${ARMEL_HOME}/include


deploy_all: deploy_libs deploy_man_page
	@echo "+-----------------------------------------------------+"
	@echo "|                                                     |"
	@echo "| finish deploy all to ${ARMEL_HOME}/... "
	@echo "|                                                     |"
	@echo "+-----------------------------------------------------+"

#
# to prepare slackware package generation (on the target!) ... building the
# real packages is done via normals slackpkg script -> see ${ARMEL_HOME}/packages/...
#
prepare_package: $(LIBNAME).host
	(rm -rf /tmp/${PKGNAME}; rm -rf /tmp/${PKGNAME}.tgz)
	mkdir -p /tmp/${PKGNAME}/lib /tmp/${PKGNAME}/include
	cp ${LIBNAME}.h /tmp/${PKGNAME}/include
	cp _lib/* /tmp/${PKGNAME}/lib/
	cp -rf man /tmp/${PKGNAME}
	(cd /tmp; tar czvf ${PKGNAME}.tgz ${PKGNAME})

-include $(DEPENDFILE)
