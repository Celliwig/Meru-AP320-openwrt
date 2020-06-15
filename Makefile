#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=powerpc
BOARD:=mpc83xx
BOARDNAME:=Freescale MPC83xx
CPU_TYPE:=603e
FEATURES:=fpu gpio rtc spi
SUBTARGETS:=meru

KERNEL_PATCHVER:=5.4

KERNELNAME:=uImage

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += \
	-ppp -ppp-mod-pppoe uboot-envtools

$(eval $(call BuildTarget))
