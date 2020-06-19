DEVICE_VARS += ROOTFS_SIZE

define Build/fullimage
	rm -f ${IMAGE_ROOTFS}.gz
	gzip -9nk ${IMAGE_ROOTFS}
	mkimage -A powerpc -O linux -C gzip -T multi \
		-a $(KERNEL_LOADADDR) -e $(if $(KERNEL_ENTRY),$(KERNEL_ENTRY),$(KERNEL_LOADADDR)) \
		-n 'Meru Networks AP320 $(VERSION_DIST) Linux-$(LINUX_VERSION)' \
		-d $(KDIR)/cuImage.meru-ap320.gz:${IMAGE_ROOTFS}.gz $@
endef

define Device/ap320
	DEVICE_VENDOR := Meru Networks
	DEVICE_MODEL := AP320
	BOARDNAME := AP320
	DEVICE_PACKAGES += wpad
	ROOTFS_SIZE := 5040k
	IMAGE_SIZE := 5040k
#	KERNEL_NAME := cuImage.meru-ap320.elf
	KERNEL := kernel-bin | gzip
	DEVICE_DTS := meru-ap320
	KERNEL_LOADADDR := 0x800000
	KERNEL_ENTRY := 0x800000
#	MTDPARTS := spi0.0:256k(u-boot)ro,256k(u-boot-env)ro,13440k(rootfs),2240k(kernel),64k(mac),128k(art)ro,15680k@0x80000(firmware)
#	IMAGES := kernel.bin rootfs.bin sysupgrade.bin
	IMAGES := fullimage.bin
#	IMAGE/kernel.bin := append-kernel | gzip | uImage gzip
#	IMAGE/rootfs.bin := append-rootfs | gzip
#	IMAGE/fullimage.bin := fullimage | check-size
	IMAGE/fullimage.bin := fullimage
#	IMAGE/sysupgrade.bin := append-rootfs | pad-rootfs | pad-to $$$$(ROOTFS_SIZE) | append-kernel | check-size $$$$(IMAGE_SIZE)
endef
TARGET_DEVICES += ap320
