# LOCAL_PATH:= $(call my-dir)
# adb_version := $(shell git -C $(LOCAL_PATH) rev-parse --short=12 HEAD 2>/dev/null)-android

# standalone Makefile for adb
SRCS+= adb.c
SRCS+= fdevent.c
SRCS+= adb_client.c
SRCS+= commandline.c
SRCS+= console.c
SRCS+= file_sync_client.c
SRCS+= get_my_path_linux.c
SRCS+= services.c
SRCS+= sockets.c
SRCS+= transport.c
SRCS+= transport_local.c
SRCS+= transport_usb.c
SRCS+= usb_linux.c
SRCS+= usb_vendors.c
SRCS+= adb_auth_host.c
 
VPATH+= ../libcutils
SRCS+= list.c
SRCS+= socket_inaddr_any_server.c
SRCS+= socket_local_client.c
SRCS+= socket_local_server.c
SRCS+= socket_loopback_client.c
SRCS+= socket_loopback_server.c
SRCS+= socket_network_client.c
SRCS+= load_file.c
 
VPATH+= ../libzipfile
SRCS+= centraldir.c
SRCS+= zipfile.c
 
VPATH+= ../../../external/zlib/src
SRCS+= adler32.c
SRCS+= compress.c
SRCS+= crc32.c
SRCS+= deflate.c
SRCS+= infback.c
SRCS+= inffast.c
SRCS+= inflate.c
SRCS+= inftrees.c
SRCS+= trees.c
SRCS+= uncompr.c
SRCS+= zutil.c

CPPFLAGS+= -DADB_HOST=1
CPPFLAGS+= -DHAVE_FORKEXEC=1
CPPFLAGS+= -DHAVE_SYMLINKS
CPPFLAGS+= -DHAVE_TERMIO_H
CPPFLAGS+= -DHAVE_SYS_SOCKET_H
CPPFLAGS+= -D_GNU_SOURCE
CPPFLAGS+= -D_XOPEN_SOURCE
# CPPFLAGS+= -DADB_REVISION='"$(adb_version)"'
CPPFLAGS+= -DADB_REVISION='"$(adb_version)"'
CPPFLAGS+= -I.
CPPFLAGS+= -I../include
CPPFLAGS+= -I../base/include
CPPFLAGS+= -I../../../external/zlib
CPPFLAGS+= -I../../../external/openssl/include
 
CFLAGS+= -O2 -g -Wall -Wno-unused-parameter
CXXFLAGS=${CFLAGS} -std=gnu++11

LIBS= -lcrypto -lpthread -lrt
 
TOOLCHAIN= /opt/poky/1.5/sysroots/x86_64-pokysdk-linux/usr/bin/arm-poky-linux-gnueabi/arm-poky-linux-gnueabi-
# CC= $(TOOLCHAIN)gcc
# LD= $(TOOLCHAIN)gcc
 
OBJS= $(SRCS:.c=.o)
 
all: adb
 
adb: $(OBJS)
	$(LD) -o $@ $(LDFLAGS) $(OBJS) $(LIBS)
 
clean:
	rm -rf $(OBJS)
