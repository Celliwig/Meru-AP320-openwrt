DEVICE_VARS += ROOTFS_SIZE

define Device/ap320
	DEVICE_VENDOR := Meru Networks
	DEVICE_MODEL := AP320
	BOARDNAME := AP320
	DEVICE_PACKAGES += wpad-basic
	UIMAGE_SIZE := 4096k
	ROOTFS_SIZE := 11008k
	KERNEL := kernel-bin
	DEVICE_DTS := meru-ap320
	FILESYSTEMS := squashfs
	IMAGES := kernel.bin rootfs.bin fdt.bin
	IMAGE/kernel.bin := append-kernel | gzip | uImage gzip | pad-to $$$$(UIMAGE_SIZE)
#	IMAGE/rootfs.bin := append-rootfs | pad-rootfs | pad-to $$$$(ROOTFS_SIZE)
	IMAGE/rootfs.bin := append-rootfs | pad-rootfs
	IMAGE/fdt.bin := append-dtb | pad-to 128k
#	IMAGE/sysupgrade.bin := append-rootfs | pad-rootfs | pad-to $$$$(ROOTFS_SIZE) | append-kernel | check-size $$$$(IMAGE_SIZE)
endef
TARGET_DEVICES += ap320
