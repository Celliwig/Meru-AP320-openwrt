DEVICE_VARS += DAP_SIGNATURE NETGEAR_BOARD_ID NETGEAR_HW_ID NETGEAR_KERNEL_MAGIC ROOTFS_SIZE
DEVICE_VARS += SEAMA_SIGNATURE SEAMA_MTDBLOCK

#define Build/alfa-network-rootfs-header
#	mkimage \
#		-A mips -O linux -T filesystem -C lzma -a 0 -e 0 \
#		-n 'RootfsImage' -d $@ $@.new
#	@mv $@.new $@
#endef

#define Build/netgear-squashfs
#	rm -rf $@.fs $@.squashfs
#	mkdir -p $@.fs/image
#	cp $@ $@.fs/image/uImage
#	$(STAGING_DIR_HOST)/bin/mksquashfs-lzma \
#		$@.fs $@.squashfs \
#		-noappend -root-owned -be -b 65536 \
#		$(if $(SOURCE_DATE_EPOCH),-fixed-time $(SOURCE_DATE_EPOCH))
#
#	dd if=/dev/zero bs=1k count=1 >> $@.squashfs
#	mkimage \
#		-A mips -O linux -T filesystem -C none \
#		-M $(NETGEAR_KERNEL_MAGIC) \
#		-a 0xbf070000 -e 0xbf070000 \
#		-n 'MIPS $(VERSION_DIST) Linux-$(LINUX_VERSION)' \
#		-d $@.squashfs $@
#	rm -rf $@.squashfs $@.fs
#endef

#define Build/netgear-uImage
#	$(call Build/uImage,$(1) -M $(NETGEAR_KERNEL_MAGIC))
#endef

#define Build/uImageHiWiFi
#	# Field ih_name needs to start with "tw150v1"
#	mkimage -A $(LINUX_KARCH) \
#		-O linux -T kernel \
#		-C $(1) -a $(KERNEL_LOADADDR) -e $(if $(KERNEL_ENTRY),$(KERNEL_ENTRY),$(KERNEL_LOADADDR)) \
#		-n 'tw150v1 $(call toupper,$(LINUX_KARCH)) $(VERSION_DIST) Linux-$(LINUX_VERSION)' -d $@ $@.new
#	@mv $@.new $@
#endef

define Build/wrgg-pad-rootfs
	$(STAGING_DIR_HOST)/bin/padjffs2 $(IMAGE_ROOTFS) -c 64 >>$@
endef

define Device/ap320
	DEVICE_TITLE := Meru Networks AP320
	DEVICE_PACKAGES := squashfs
	BOARDNAME := AP320
	TARGET_ROOTFS_PARTSIZE := 5040k
	ROOTFS_SIZE := 5040k
	IMAGE_SIZE := 10080k
#	MTDPARTS := spi0.0:256k(u-boot)ro,256k(u-boot-env)ro,13440k(rootfs),2240k(kernel),64k(mac),128k(art)ro,15680k@0x80000(firmware)
	IMAGE/kernel.bin := append-kernel
#	IMAGE/rootfs.bin := append-rootfs | pad-rootfs
#	IMAGE/sysupgrade.bin := append-rootfs | pad-rootfs | pad-to $$$$(ROOTFS_SIZE) | append-kernel | check-size $$$$(IMAGE_SIZE)
#	IMAGES := kernel.bin rootfs.bin sysupgrade.bin
endef
TARGET_DEVICES += ap320

#define Device/ap91-5g
#  DEVICE_TITLE := ALFA Network AP91-5G
#  DEVICE_PACKAGES := rssileds -swconfig
#  BOARDNAME := AP91-5G
#  IMAGE_SIZE := 7744k
#  KERNEL_SIZE := 1600k
#  ROOTFS_SIZE := 6144k
#  MTDPARTS := spi0.0:256k(u-boot)ro,64k(u-boot-env),6144k(rootfs),1600k(kernel),64k(config)ro,64k(art)ro,7744k@0x50000(firmware)
#  IMAGES := sysupgrade.bin factory.bin
#  IMAGE/factory.bin := append-rootfs | pad-rootfs |\
#	alfa-network-rootfs-header | append-kernel | check-size $$$$(IMAGE_SIZE)
#  IMAGE/sysupgrade.bin := append-rootfs | pad-rootfs |\
#	pad-to $$$$(ROOTFS_SIZE) | append-kernel | check-size $$$$(IMAGE_SIZE)
#endef

